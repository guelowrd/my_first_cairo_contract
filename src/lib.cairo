#[starknet::interface]
trait IData<T> {
    fn get_data(self: @T) -> felt252;
    fn set_data(ref self: T, new_value: felt252);
}

#[starknet::contract]
mod ownable {
    use starknet::{ContractAddress, get_caller_address};
    use super::IData;

    #[storage]
    struct Storage {
        owner: ContractAddress,
        data: felt252,
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_owner: ContractAddress) {
        self.owner.write(initial_owner);
    }

    #[external(v0)]
    impl OwnableDataImpl of IData<ContractState> {
        fn get_data(self: @ContractState) -> felt252 {
            self.data.read()
        }

        fn set_data(ref self: ContractState, new_value: felt252) {
            self.only_owner();
            self.data.write(new_value);
        }
    }

    #[generate_trait]
    impl PrivateMethods of PrivateMethodsTrait {
        fn only_owner(self: @ContractState) {
            assert(get_caller_address() == self.owner.read(), 'Caller is not the owner.');
        }
    }
}
