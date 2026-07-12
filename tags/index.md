---
layout: page
title: Temas
permalink: /tags/
description: Explora las publicaciones de Apuntes de Java por tema.
---

# Temas

<p class="lead">Explora el archivo completo agrupado por tecnologías y temas.</p>

<div class="tag-index">
{% assign sorted_tags = site.tags | sort %}
{% for tag in sorted_tags %}
  {% assign tag_slug = tag[0] | slugify %}
  <a href="{{ '/tags/' | append: tag_slug | append: '/' | relative_url }}"><span>{{ tag[0] }}</span><small>{{ tag[1].size }}</small></a>
{% endfor %}
</div>
