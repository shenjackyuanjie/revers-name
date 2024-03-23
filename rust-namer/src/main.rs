use thirtyfour::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct WinData {
    pub all: Vec<Vec<Vec<String>>>,
    pub winners: Vec<String>,
    
}

#[tokio::main]
async fn main() -> WebDriverResult<()> {

    let insert = include_str!("../insert.js");

    let caps = DesiredCapabilities::edge();
    let driver = WebDriver::new("http://localhost:9515", caps).await?;

    // Navigate to https://wikipedia.org.
    driver.goto("https://shenjack.top:82/md5").await?;
    tokio::time::sleep(std::time::Duration::from_secs(1)).await;
    // driver.minimize_window().await?;

    driver.execute(insert, vec![]).await?;

    let done_target = driver.find(By::Id("done_target")).await?;
    let go_btn = driver.find(By::ClassName("goBtn")).await?;
    let fast_forward_btn = driver.find(By::Id("fastBtn")).await?;

    let name_input = driver.find(By::Id("input_name")).await?;

    // println!("name_input: {:?}, go_btn: {:?}", name_input, go_btn);

    name_input.send_keys("shen@jack\nshennnnn").await?;

    go_btn.click().await?;
    tokio::time::sleep(std::time::Duration::from_millis(100)).await; // 等一会
    fast_forward_btn.click().await?;

    done_target
        .wait_until()
        .has_attribute("done", "true")
        .await?;

    let win_data = driver
        .execute("return arguments[0].win_data", vec![done_target.to_json()?])
        .await?;
    println!("win_data: {:?}", win_data.json());

    driver.quit().await?;

    Ok(())
}
