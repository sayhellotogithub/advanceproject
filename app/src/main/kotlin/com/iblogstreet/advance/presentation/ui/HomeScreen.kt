package com.iblogstreet.advance.presentation.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.paddingFromBaseline
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Face
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.iblogstreet.advance.R
import com.iblogstreet.advance.domain.model.EntryType
import com.iblogstreet.advance.util.data_util

/**
 * @author junwang
 * @date 2025/05/12 18:40
 */
@Composable
fun HomeScreen(
    modifier: Modifier, callBack: ((EntryType) -> Unit)?
) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Spacer(Modifier.height(16.dp))
        ItemSection(title = "photo") {
            photoList()
        }
        ItemSection(title = "module") {

            ModuleButton(
                buttonText = stringResource(id = R.string.button_login_text),
                buttonClick = {
                    callBack?.invoke(EntryType.LOGIN)
                })
            ModuleButton(
                buttonText = stringResource(id = R.string.button_features_text),
                buttonClick = {
                    callBack?.invoke(EntryType.FEATURES)
                })
            ModuleButton(
                buttonText = stringResource(id = R.string.button_photo_text),
                buttonClick = {
                    callBack?.invoke(EntryType.PHOTO)
                })
            ModuleButton(
                buttonText = stringResource(id = R.string.button_explore_ar_text),
                buttonClick = {
                    callBack?.invoke(EntryType.EXPLORE_AR)
                })

        }
        Spacer(Modifier.height(16.dp))
    }
}

@Composable
private fun ModuleButton(buttonText: String, buttonClick: (() -> Unit)?) {
    Button(
        modifier = Modifier
            .padding(horizontal = 16.dp)
            .padding(bottom = 8.dp),
        onClick = {
            buttonClick?.invoke()
        }, colors = ButtonDefaults.buttonColors(
            containerColor = Color.Blue,
            contentColor = Color.White
        ), shape = RoundedCornerShape(12.dp),
        elevation = ButtonDefaults.buttonElevation(4.dp)
    ) {
        Text(text = buttonText)
    }
}


@Composable
fun photoList(modifier: Modifier = Modifier) {
    LazyRow(
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        contentPadding = PaddingValues(horizontal = 16.dp),
        modifier = modifier
    ) {
        items(data_util.photos.size) { item ->
            PhotoItem(text = data_util.photos.get(item))
        }
    }
}


@Composable
fun PhotoItem(modifier: Modifier = Modifier, text: String? = null) {
    Column(
        modifier = modifier,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            imageVector = Icons.Default.Face,
            contentDescription = null,
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .size(88.dp)
                .clip(CircleShape)
        )
        Text(
            text = text ?: "",
            modifier = Modifier.paddingFromBaseline(top = 24.dp, bottom = 8.dp),
            style = MaterialTheme.typography.bodyMedium
        )
    }
}


@Composable
fun ItemSection(
    title: String? = null, modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    Column(modifier) {
        Text(
            text = title ?: "",
            style = MaterialTheme.typography.titleMedium,
            modifier = Modifier
                .paddingFromBaseline(top = 40.dp, bottom = 16.dp)
                .padding(horizontal = 16.dp)
        )
        content()
    }
}

@Composable
fun SearchBar(modifier: Modifier = Modifier) {
    TextField(
        value = "",
        onValueChange = {},
        leadingIcon = {
            Icon(
                imageVector = Icons.Default.Search, contentDescription = null
            )
        },
        colors = TextFieldDefaults.colors(
            unfocusedContainerColor = MaterialTheme.colorScheme.surface,
            focusedContainerColor = MaterialTheme.colorScheme.surface
        ),
        placeholder = { Text(stringResource(id = R.string.placeholder_search)) }
    )
}

