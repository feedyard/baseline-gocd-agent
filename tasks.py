from invoke import task
import sys
# from paramiko import SSHClient, AutoAddPolicy
# import os


@task
def bl(ctx):
    build(ctx, 'feedyard', 'baseline-gocd-agent', 'latest')

@task
def tl(ctx):
    test(ctx, 'feedyard', 'baseline-gocd-agent', 'latest')


@task
def test(ctx, library, imagename, version):
    ctx.run("inspec exec profiles/cis-docker", pty=True)
    container_id = ctx.run("docker run -it -d {0}/{1}:{2} ash".format(library, imagename, version)).stdout
    results = ctx.run("inspec exec profiles/{0}/ -t docker://{1}".format(imagename, container_id), pty=True, warn=True)
    ctx.run("docker rm --force {}".format(container_id), pty=True)
    if results.exited:
        sys.exit(1)

@task
def build(ctx, library, imagename, version):
    ctx.run("docker build -t {0}/{1}:{2} .".format(library, imagename, version), pty=True)



