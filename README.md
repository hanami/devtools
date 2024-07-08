# Hanami::Devtools

These are various tools we use for developing [Hanami](https://github.com/hanami).

**You probably don't want to use this gem**, unless you're working on Hanami.

One way you could use it in a project is to inherit from Hanami's Rubocop config.

To do that, start your `.rubocop.yml` file with:

```yml
inherit_from:
  https://raw.githubusercontent.com/hanami/devtools/main/.rubocop.yml
```

Then you can add more below it as needed.

Be aware thought that we provide no commitment to keeping this file stable:
it's merely our preferences for working on Hanami _libraries_.
We politely decline requests to change it based on how you use it in your _projects_.
If you don't like a rule, please override it in your `.rubocop.yml` file :)
