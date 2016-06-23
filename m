Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48851 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbcFWNpR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 09:45:17 -0400
Subject: Re: [PATCH 2/2] Documentation/watchdog: add support for magic close
 to watchdog-test
To: Timur Tabi <timur@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
References: <1466550015-14924-1-git-send-email-timur@codeaurora.org>
 <1466550015-14924-2-git-send-email-timur@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576BE7DF.6020209@roeck-us.net>
Date: Thu, 23 Jun 2016 06:45:03 -0700
MIME-Version: 1.0
In-Reply-To: <1466550015-14924-2-git-send-email-timur@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/21/2016 04:00 PM, Timur Tabi wrote:
> Some drivers have the WDIOF_MAGICCLOSE set, which means that applications
> need to write 'V' to the watchdog device before closing, otherwise the
> driver won't stop the watchdog timer.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/watchdog/src/watchdog-test.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
> index b3cc7aa..c691539 100644
> --- a/Documentation/watchdog/src/watchdog-test.c
> +++ b/Documentation/watchdog/src/watchdog-test.c
> @@ -13,6 +13,7 @@
>   #include <linux/watchdog.h>
>
>   int fd;
> +const char v = 'V';
>
>   /*
>    * This function simply sends an IOCTL to the driver, which in turn ticks
> @@ -34,6 +35,7 @@ static void keep_alive(void)
>
>   static void term(int sig)
>   {
> +    write(fd, &v, 1);
>       close(fd);
>       printf("\nStopping watchdog ticks...\n");
>       exit(0);
> @@ -89,6 +91,7 @@ int main(int argc, char *argv[])
>   	sleep(ping_rate);
>       }
>   end:
> +    write(fd, &v, 1);
>       close(fd);
>       return 0;
>   }
>

