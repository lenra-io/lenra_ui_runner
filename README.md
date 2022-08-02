<div id="top"></div>
<!--
*** This README was created with https://github.com/othneildrew/Best-README-Template
-->



<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">

<h3 align="center">Lenra UI Runner</h3>

  <p align="center">
    Implementation of the Lenra Component API in Dart with the Flutter framework.
    <br />
    <br />
    <a href="https://github.com/lenra-io/lenra_ui_runner/issues">Report Bug</a>
    ·
    <a href="https://github.com/lenra-io/lenra_ui_runner/issues">Request Feature</a>
  </p>
</div>

## Lenra component system

### LenraUiBuilder
It is a Stateful Widget which takes care of transforming the UI and Patchs into usable widget/properties : 

 - It takes both streams (UI and Patch) as input 

 - It builds the components **LenraWrapper**.
 - It manages the modification of the properties by the patch.

 - Notifies **LenraWrapper** when their properties change.
 - It knows all the properties and **LenraWrapper** of the app.
 - It displays the **LenraWrapper** corresponding to the "root" component of the UI.

### LenraWrapper
This is the "smart" parent component of all Lenra display components.

- It instantiates the display component according to the type.

- It parses JSON properties into useful objects for the display component.

## Running tests
### Prerequisites

You need to generate the mockito mocks for the tests to properly run. This can be done by running the following command :

```bash
flutter pub run build_runner build
```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please open an issue with the tag "enhancement".
Don't forget to give the project a star if you liked it! Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the **MIT** License. See [LICENSE](./LICENSE) for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Lenra - [@lenra_dev](https://twitter.com/lenra_dev) - contact@lenra.io

Project Link: [https://github.com/lenra-io/lenra_ui_runner](https://github.com/lenra-io/lenra_ui_runner)

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lenra-io/lenra_ui_runner.svg?style=for-the-badge
[contributors-url]: https://github.com/lenra-io/lenra_ui_runner/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lenra-io/lenra_ui_runner.svg?style=for-the-badge
[forks-url]: https://github.com/lenra-io/lenra_ui_runner/network/members
[stars-shield]: https://img.shields.io/github/stars/lenra-io/lenra_ui_runner.svg?style=for-the-badge
[stars-url]: https://github.com/lenra-io/lenra_ui_runner/stargazers
[issues-shield]: https://img.shields.io/github/issues/lenra-io/lenra_ui_runner.svg?style=for-the-badge
[issues-url]: https://github.com/lenra-io/lenra_ui_runner/issues
[license-shield]: https://img.shields.io/github/license/lenra-io/lenra_ui_runner.svg?style=for-the-badge
[license-url]: https://github.com/lenra-io/lenra_ui_runner/blob/master/LICENSE

