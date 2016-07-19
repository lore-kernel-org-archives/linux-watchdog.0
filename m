Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53886 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbcGSOym (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 10:54:42 -0400
Subject: Re: [PATCH] Documentation/watchdog: check return value for magic
 close
To: Arnd Bergmann <arnd@arndb.de>, Wim Van Sebroeck <wim@iguana.be>
References: <20160719092522.6397-1-arnd@arndb.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Timur Tabi <timur@codeaurora.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fc9151de-4870-8441-5e75-7504a0eb107e@infradead.org>
Date: Tue, 19 Jul 2016 07:54:37 -0700
MIME-Version: 1.0
In-Reply-To: <20160719092522.6397-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 07/19/16 02:24, Arnd Bergmann wrote:
> A recent commit added a write to the watchdog test code for doing the "=
magic
> close", but that caused a compile-time warning:
>=20
> Documentation/watchdog/src/watchdog-test.c: In function =E2=80=98main=E2=
=80=99:
> Documentation/watchdog/src/watchdog-test.c:94:5: warning: ignoring retu=
rn value of =E2=80=98write=E2=80=99, declared with attribute warn_unused_=
result [-Wunused-result]
>=20
> This changes the code to print a runtime warning if the write fails.
>=20
> Fixes: 5a2d3de19602 ("Documentation/watchdog: add support for magic clo=
se to watchdog-test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/watchdog/src/watchdog-test.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation=
/watchdog/src/watchdog-test.c
> index c69153913722..52eea54649ab 100644
> --- a/Documentation/watchdog/src/watchdog-test.c
> +++ b/Documentation/watchdog/src/watchdog-test.c
> @@ -2,6 +2,7 @@
>   * Watchdog Driver Test Program
>   */
> =20
> +#include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -35,9 +36,13 @@ static void keep_alive(void)
> =20
>  static void term(int sig)
>  {
> -    write(fd, &v, 1);
> +    int ret =3D write(fd, &v, 1);
> +
>      close(fd);
> -    printf("\nStopping watchdog ticks...\n");
> +    if (ret < 0)
> +	printf("\nStopping watchdog ticks failed (%d)...\n", errno);
> +    else
> +	printf("\nStopping watchdog ticks...\n");
>      exit(0);
>  }
> =20
> @@ -45,6 +50,7 @@ int main(int argc, char *argv[])
>  {
>      int flags;
>      unsigned int ping_rate =3D 1;
> +    int ret;
> =20
>      setbuf(stdout, NULL);
> =20
> @@ -91,7 +97,9 @@ int main(int argc, char *argv[])
>  	sleep(ping_rate);
>      }
>  end:
> -    write(fd, &v, 1);
> +    ret =3D write(fd, &v, 1);
> +    if (ret < 0)
> +	printf("Sopping watchdog ticks failed (%d)...\n", errno);

Stopping

>      close(fd);
>      return 0;
>  }
>=20


--=20
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
