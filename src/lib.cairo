#[starknet::contract]
mod ownable {
    use starknet::ContractAddress;
    #[storage]
    struct Storage {
        owner: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_owner: ContractAddress) {
        self.owner.write(initial_owner);
    }
}
