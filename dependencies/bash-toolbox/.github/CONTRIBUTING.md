# Contributing

Thank you for your interest in contributing to this repository! To ensure a smooth and collaborative process, please follow these guidelines.

## Before You Start

Before making any changes, please discuss the proposed change with the repository owners. You can do this via an issue, email, or any other communication method.

## Code of Conduct

Please adhere to our [Code of Conduct](./CODE_OF_CONDUCT.md) in all your interactions with the project.

## Internationalization (I18N)

All contributions should be in English to ensure that all members of the community can understand and contribute to the project. Translations can be provided in addition to the English version. It is recommended to use the [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) standard for language codes.

## Documentation

Documentation is mandatory for all contributions, including code, issues, and pull requests. The documentation should be:

- Clear and concise
- Written in Markdown format
- Included in the `README.md` file at the root of the project
- Additional documentation can be added to the `docs` folder

## Deployment

Every solution should include a Docker deployment option, with a `compose.yml` and `Dockerfile` if necessary. The deployment process should be:

- As simple as possible
- Documented in the `README.md` file

## Testing

All contributions should include tests to ensure the stability and reliability of the project. Please follow these guidelines for testing:

- Write unit tests for new functionality and bug fixes.
- Use a testing framework appropriate for the project's language and environment.
- Ensure that all tests pass before submitting a pull request.
- Include instructions on how to run the tests in the README.md file.

## Commit Messages

All commit messages should follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format. This format ensures that the commit messages are easy to read and follow a consistent structure.

The use of emojis in commit messages is encouraged to make the messages more engaging and easier to understand.

## Git strategy

All contributions should follow the [GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) branching model. The main branches are:

- `main`: The main branch for the project. This branch should always be stable and deployable.
- `develop`: The development branch for the project. All feature branches should be merged into this branch.
- `feature/*`: Feature branches for new functionality. These branches should be merged into the `develop` branch.
- `hotfix/*`: Hotfix branches for critical bug fixes. These branches should be merged into the `main` and `develop` branches.
- `release/*`: Release branches for preparing a new release. These branches should be merged into the `main` and `develop` branches.
- `support/*`: Support branches for long-term support. These branches should be merged into the `main` branch.
- `docs/*`: Documentation branches for updating the documentation. These branches should be merged into the `main` branch.

## Archiving

Each project within the DeVinci Fablab organization should be archived when it is no longer maintained. This includes projects that have been completed or abandoned.

## Licensing

All public projects within the DeVinci Fablab organization are licensed under the [MIT License](../LICENSE).

---

By following these guidelines, you help ensure that the project remains well-organized, accessible, and collaborative. Thank you for your contributions!
