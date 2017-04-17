Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49824 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757049AbdDQBNN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 16 Apr 2017 21:13:13 -0400
Subject: Re: [PATCH] selftests: watchdog: accept multiple params on command
 line
To: Timur Tabi <timur@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kselftest@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <1490730277-30200-1-git-send-email-timur@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <40133281-90e2-1b9e-2f86-35c2d02eb168@roeck-us.net>
Date: Sun, 16 Apr 2017 18:13:11 -0700
MIME-Version: 1.0
In-Reply-To: <1490730277-30200-1-git-send-email-timur@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/28/2017 12:44 PM, Timur Tabi wrote:
> Watchdog drivers are not required to retain programming information,
> such as timeouts, after the watchdog device is closed.  Therefore,
> the watchdog test should be able to perform multiple actions after
> opening the watchdog device.
>
> For example, to set the timeout to 10s and ping every 5s:
>
> 	watchdog-test -t 10 -p 5 -e
>
> Also, display the periodic decimal point only if the keep-alive call
> succeeds.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  tools/testing/selftests/watchdog/watchdog-test.c | 61 +++++++++++++-----------
>  1 file changed, 34 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index 6983d05..a74c9d7 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -24,9 +24,11 @@
>  static void keep_alive(void)
>  {
>      int dummy;
> +    int ret;
>
> -    printf(".");
> -    ioctl(fd, WDIOC_KEEPALIVE, &dummy);
> +    ret = ioctl(fd, WDIOC_KEEPALIVE, &dummy);
> +    if (!ret)
> +        printf(".");
>  }
>
>  /*
> @@ -51,6 +53,7 @@ int main(int argc, char *argv[])
>      int flags;
>      unsigned int ping_rate = 1;
>      int ret;
> +    int i;
>
>      setbuf(stdout, NULL);
>
> @@ -61,31 +64,35 @@ int main(int argc, char *argv[])
>  	exit(-1);
>      }
>
> -    if (argc > 1) {
> -	if (!strncasecmp(argv[1], "-d", 2)) {
> -	    flags = WDIOS_DISABLECARD;
> -	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
> -	    printf("Watchdog card disabled.\n");
> -	    goto end;
> -	} else if (!strncasecmp(argv[1], "-e", 2)) {
> -	    flags = WDIOS_ENABLECARD;
> -	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
> -	    printf("Watchdog card enabled.\n");
> -	    goto end;
> -	} else if (!strncasecmp(argv[1], "-t", 2) && argv[2]) {
> -	    flags = atoi(argv[2]);
> -	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
> -	    printf("Watchdog timeout set to %u seconds.\n", flags);
> -	    goto end;
> -	} else if (!strncasecmp(argv[1], "-p", 2) && argv[2]) {
> -	    ping_rate = strtoul(argv[2], NULL, 0);
> -	    printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
> -	} else {
> -	    printf("-d to disable, -e to enable, -t <n> to set " \
> -		"the timeout,\n-p <n> to set the ping rate, and \n");
> -	    printf("run by itself to tick the card.\n");
> -	    goto end;
> -	}
> +    for (i = 1; i < argc; i++) {
> +        if (!strncasecmp(argv[i], "-d", 2)) {
> +            flags = WDIOS_DISABLECARD;
> +            ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
> +            if (!ret)
> +                printf("Watchdog card disabled.\n");
> +        } else if (!strncasecmp(argv[i], "-e", 2)) {
> +            flags = WDIOS_ENABLECARD;
> +            ret = ioctl(fd, WDIOC_SETOPTIONS, &flags);
> +            if (!ret)
> +                printf("Watchdog card enabled.\n");
> +        } else if (!strncasecmp(argv[i], "-t", 2) && argv[2]) {
> +            flags = atoi(argv[i + 1]);
> +            ret = ioctl(fd, WDIOC_SETTIMEOUT, &flags);
> +            if (!ret)
> +                printf("Watchdog timeout set to %u seconds.\n", flags);
> +            i++;
> +        } else if (!strncasecmp(argv[i], "-p", 2) && argv[2]) {
> +            ping_rate = strtoul(argv[i + 1], NULL, 0);
> +            printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
> +            i++;
> +        } else {
> +            printf("-d to disable, -e to enable, -t <n> to set "
> +                "the timeout,\n-p <n> to set the ping rate, and ");
> +            printf("run by itself to tick the card.\n");
> +            printf("Parameters are parsed left-to-right in real-time.\n");
> +            printf("Example: %s -d -t 10 -p 5 -e\n", argv[0]);
> +            goto end;
> +        }
>      }
>
>      printf("Watchdog Ticking Away!\n");
>

