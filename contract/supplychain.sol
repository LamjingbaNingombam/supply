pragma solidity ^0.8.0;

contract SupplyChain {

    enum State { Manufactured, InTransit, Delivered }
    struct Product {
        uint256 id;
        string name;
        address manufacturer;
        State state;
    }

    mapping(uint256 => Product) public products;

    event ProductStateChanged(uint256 indexed productId, State state);

    function addProduct(uint256 _id, string memory _name) public {
        require(products[_id].id == 0, "Product already exists");

        products[_id] = Product({
            id: _id,
            name: _name,
            manufacturer: msg.sender,
            state: State.Manufactured
        });

        emit ProductStateChanged(_id, State.Manufactured);
    }

    function updateProductState(uint256 _id, State _state) public {
        require(products[_id].id != 0, "Product does not exist");
        require(products[_id].state != State.Delivered, "Product already delivered");

        products[_id].state = _state;

        emit ProductStateChanged(_id, _state);
    }

    function getProduct(uint256 _id) public view returns (uint256, string memory, address, State) {
        require(products[_id].id != 0, "Product does not exist");
        Product memory product = products[_id];
        return (product.id, product.name, product.manufacturer, product.state);
    }
}
