# Hanami::Devtools

These are various tools we use for developing [Hanami](https://github.com/hanami).

**You probably don't want to use this gem**, unless you're working on Hanami.

One way you could use it in a project is to inherit from Hanami's Rubocop config.

To do that, start your `.rubocop.yml` file with:

```yml
inherit_from:
  https://raw.githubusercontent.com/hanami/devtools/master/.rubocop.yml
```

Then you can add more below it as needed.

Be aware thought that we provide no commitment to keeping this file stable:
it's merely our preferences for working on Hanami _libraries_.
We're not interested in changing it based on how you're using it in Hanami _projects_.
If you don't like a rule, you can override it in your `.rubocop.yml` file.
