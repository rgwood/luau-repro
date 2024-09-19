use mlua::Lua;

fn main() {
    let lua = Lua::new();
    lua.load("print('Hello, Lua!!')").exec().unwrap();
}
