## Legal

By submitting a pull request, you represent that you have the right to license your contribution to the community, and agree by submitting the patch
that your contributions are licensed under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.html) (see [`LICENSE`](../LICENSE)).

## Submitting a Bug

Please ensure to specify the following:

* **CosmosSwift/swift-abci** commit hash
* Simplest possible steps to reproduce
* A pull request with a failing test case is preferred, but it's just as fine to write it in the issue description
* Environment Information
* For example, are you running in Docker? How are you connecting to it through Docker? What version of Docker?
* OS version and output of `uname -a`
* Swift version or output of `swift --version`

## Development

### Git Workflow

`master` is always the development branch.

For **minor** or **patch** SemVer changes, create a branch off of the tagged commit.

### Environment Setup

It is highly recommended to use [Docker](https://docker.com) to work with Tendermint locally.

```bash
docker run -it --rm -v "/tmp:/tendermint" tendermint/tendermint init

docker run -it --rm -v "/tmp:/tendermint" -p "26656-26657:26656-26657"  tendermint/tendermint node --proxy_app="tcp://host.docker.internal:26658"
```

Otherwise, install Tendermint directly on your machine from [Tendermint.com](https://tendermint.com/docs/introduction/quick-start.html#overview).

### Submitting a Pull Request

A great PR that is likely to be merged quickly is:

1. Concise, with as few changes as needed to achieve the end result.
1. Tested, ensuring that regressions aren't introduced now or in the future.
1. Documented, adding API documentation as needed to cover new functions and properties.
1. Accompanied by a [great commit message](https://chris.beams.io/posts/git-commit/)

# Contributor Conduct

All contributors are expected to adhere to this project's [Code of Conduct](CODE_OF_CONDUCT.md).
