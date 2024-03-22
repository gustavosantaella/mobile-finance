import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import com.softlink.wafi.R

@Composable
fun RenderMainLogo(){
    Image(
        modifier = Modifier.height(180.dp).width(180.dp),
        painter = painterResource(id = R.drawable.logo),
        contentDescription = "Main Logo"
    )
}