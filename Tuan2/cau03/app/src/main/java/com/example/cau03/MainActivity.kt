package com.example.cau03

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.border
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.cau03.ui.theme.Cau03Theme
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.foundation.BorderStroke


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            Cau03Theme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Greeting(
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}

@Composable
fun Greeting(modifier: Modifier = Modifier) {
    var tuoi by remember { mutableStateOf("") }

    Column(
        modifier = modifier
            .fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Top
    ) { Spacer(modifier = Modifier.height(60.dp))
        Text(
            "THỰC HÀNH 01",
            fontSize = 27.sp,
            fontWeight = FontWeight.Bold
        )
        Spacer(modifier = Modifier.height(25.dp))
        Column(
            modifier = Modifier
                .border(1.dp, Color.Gray, RoundedCornerShape(12.dp))
                .wrapContentSize()
                .width(350.dp)
                .background(Color(0xFFD3D3D3))
        ){
            Spacer(modifier = Modifier.height(15.dp))
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(15.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ){
                Text(
                    "Họ và tên",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold
                );
                var hoten by remember { mutableStateOf("") }
                TextField(
                    value = hoten,
                    onValueChange = { hoten = it},
                    label = { Text("") },
                    colors = TextFieldDefaults.colors(
                        focusedContainerColor = Color.White,
                        unfocusedContainerColor = Color.White
                    ),
                    modifier = Modifier
                        .border(1.dp, Color.Gray, RoundedCornerShape(12.dp))
                        .clip(RoundedCornerShape(20.dp))
                        .width(200.dp)

                    )
            }
            Spacer(modifier = Modifier.height(15.dp))

            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(15.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ){
                Text(
                    "Tuổi",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold
                );
                TextField(
                    value = tuoi,
                    onValueChange = { tuoi = it},
                    label = { Text("") },
                    colors = TextFieldDefaults.colors(
                        focusedContainerColor = Color.White,
                        unfocusedContainerColor = Color.White
                    ),
                    modifier = Modifier
                        .border(1.dp, Color.Gray, RoundedCornerShape(12.dp))
                        .clip(RoundedCornerShape(20.dp))
                        .width(200.dp),
                    )
            }
            Spacer(modifier = Modifier.height(15.dp))

        }
        Spacer(modifier = Modifier.height(25.dp))

        var result by remember { mutableStateOf("") }
        Spacer(modifier = Modifier.height(6.dp))
        Text(
            result,
            color = Color.Red
        )
        Spacer(modifier = Modifier.height(6.dp))
        Button(
            colors = ButtonDefaults.buttonColors(
                containerColor = Color.Blue,
                contentColor = Color.White
            ),
            onClick = {
                val tuoiso = tuoi.toIntOrNull() ?: 0
                result = when {
                    tuoiso > 65 -> "Người già"
                    tuoiso in 6..65 -> "Người lớn"
                    tuoiso in 2..6 -> "Trẻ em"
                    else -> "Em bé"
                }
            },
            modifier = Modifier
                .width(270.dp)
                .height(50.dp)
        ) {
            Text(
                text = "Kiểm tra",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold
            )
        }

    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    Cau03Theme {
        Greeting()
    }
}