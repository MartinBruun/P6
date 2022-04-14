from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.response import Response

# Should probably be moved to a seperate Security App

class UserAndAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        
        response_json = {
            "token": token.key,
            "user_id": user.id,
            "email": user.email,
            "username": user.username,
            "accounts": []
        }
        
        for account in user.accounts.all():
            response_json["accounts"].append({
                "account_id": account.id,
                "name": account.name,
                "balance": account.balance   
            })
        
        return Response(response_json)