Return-path: <ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
In-Reply-To: <55B1A33D.8010502@roeck-us.net>
References: <1437682876-1561-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<55B1A33D.8010502@roeck-us.net>
Date: Fri, 24 Jul 2015 09:24:00 -0300
Message-ID: <CAAEAJfAQ+Pjkuzdo+-0E7n_jEM51ErmKftG49vZ7BVB7kvQg=Q@mail.gmail.com>
Subject: Re: [PATCH] watchdog: imgpdc: Unregister restart handler on remove
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	"Ariel D'Alessandro" <ariel@vanguardiasur.com.ar>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

On 23 July 2015 at 23:30, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/23/2015 01:21 PM, Ezequiel Garcia wrote:
>>
>> Commit c631f20068 ("watchdog: imgpdc: Add reboot support") introduced
>> a restart handler but forgot to unregister it on driver removal. Fix it.
>>
>> Fixes: c631f20068 ("watchdog: imgpdc: Add reboot support")
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
>
> Good catch.

In fact, it was Ariel's catch. I forgot to add his reported-by:

Reported-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

> Looks good. Note that you should use a 12-character SHA
> (c631f2006836).
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
