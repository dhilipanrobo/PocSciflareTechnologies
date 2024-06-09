# POC_Sciflare_Technologies

## Overview

This project demonstrates how to use a `HelperFile` to change key values via `EndPointManager` and write basic test cases in SwiftUI.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [License](#license)

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/dhilipanrobo/POC_Sciflare_Technologies.git
    cd POC_Sciflare_Technologies
    ```

2. Open the project in Xcode:
    ```sh
    open POC_Sciflare_Technologies.xcodeproj
    ```

3. Build and run the project using Xcode.

## Usage

### HelperFile

The `HelperFile` class provides utility functions to manage key-value pairs.

#### Example

HelperFile -> EndPointManager 

public func devUrl()->String {
    let baseUrl = "https://crudcrud.com/api/"
    let key = "8c1691e7fbb344d8ab4cf5cc640533e2/"
    let rout = "users"
    return "\(baseUrl)\(key)\(rout)"
}
