from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    app_name: str = "Jarvis Assistant API"
    api_prefix: str = "/api/v1"
    database_url: str = "sqlite:///./jarvis.db"
    offline_mode_default: bool = True
    voice_activation_keyword: str = "jarvis"

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")


settings = Settings()
