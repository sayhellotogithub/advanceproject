From chatgpt

Android で **MVVM（Model-View-ViewModel）** アーキテクチャを使うと、コードの分離が明確になり、保守性やテストのしやすさが向上します。

------

## **MVVM の基本構成**

1. **Model（データ層）**
   - リポジトリやデータソース（Room, Retrofit など）
   - ビジネスロジックを担当
2. **View（UI 層）**
   - `Activity` / `Fragment` / `Compose`
   - `ViewModel` のデータを監視して UI を更新
3. **ViewModel（ロジック層）**
   - `LiveData` / `StateFlow` で `View` にデータを提供
   - `Model` からデータを取得して保持する

------

## **MVVM の実装例（Jetpack Compose）**

### **1. 依存関係を追加（build.gradle）**

```
dependencies {
    implementation "androidx.lifecycle:lifecycle-viewmodel-ktx:2.6.2"
    implementation "androidx.lifecycle:lifecycle-livedata-ktx:2.6.2"
    implementation "androidx.activity:activity-compose:1.7.2"
}
```

------

### **2. Model（データ層）**

```
data class NewsArticle(
    val id: String,
    val title: String,
    val date: String
)

class NewsRepository {
    fun getLatestNews(): List<NewsArticle> {
        return listOf(
            NewsArticle("001", "New Android Version Released", "2025-02-17"),
            NewsArticle("002", "Jetpack Compose Best Practices", "2025-02-16")
        )
    }
}
```

------

### **3. ViewModel（ロジック層）**

```
import androidx.lifecycle.ViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

class NewsViewModel : ViewModel() {
    private val repository = NewsRepository()

    private val _newsList = MutableStateFlow<List<NewsArticle>>(emptyList())
    val newsList: StateFlow<List<NewsArticle>> = _newsList

    fun fetchNews() {
        _newsList.value = repository.getLatestNews()
    }
}
```

------

### **4. View（Jetpack Compose）**

```
import androidx.compose.runtime.*
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.lifecycle.viewmodel.compose.viewModel

@Composable
fun NewsScreen(viewModel: NewsViewModel = viewModel()) {
    val newsList by viewModel.newsList.collectAsState()

    Column(modifier = Modifier.fillMaxSize().padding(16.dp)) {
        Button(onClick = { viewModel.fetchNews() }) {
            Text("Get News")
        }
        Spacer(modifier = Modifier.height(16.dp))
        newsList.forEach { news ->
            Text(text = "${news.title} - ${news.date}")
        }
    }
}
```

------

### **5. MainActivity（エントリーポイント）**

```
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            NewsScreen()
        }
    }
}
```

------

## **MVVM のポイント**

✅ `ViewModel` は `Activity` や `Fragment` から UI の状態管理を切り離す
✅ `StateFlow` / `LiveData` を使ってリアクティブに UI を更新
✅ `Repository` を作ることで、データ取得のロジックを分離

------

### **さらに発展させるには？**

- **Room** を使ってローカルデータベース管理
- **Retrofit** で API からデータ取得
- **Hilt** で `ViewModel` や `Repository` を DI する
- **Jetpack Navigation** で画面遷移を管理