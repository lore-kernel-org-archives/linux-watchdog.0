Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47891 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbcFWNoa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 09:44:30 -0400
Subject: Re: [PATCH 1/2] Documentation/watchdog: use stdout instead of stderr
 in watchdog-test
To: Timur Tabi <timur@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
References: <1466550015-14924-1-git-send-email-timur@codeaurora.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576BE7BB.9020005@roeck-us.net>
Date: Thu, 23 Jun 2016 06:44:27 -0700
MIME-Version: 1.0
In-Reply-To: <1466550015-14924-1-git-send-email-timur@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/21/2016 04:00 PM, Timur Tabi wrote:
> The watchdog-test utility outputs all messages to stderr, even those
> that are not error messages.  Output to stdout instead.
>
> Instead of flushing the output after every write, just disabled
> the output buffer.
>
> Also display a dot for every ping of the watchdog, so that the user
> knows that it's working.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/watchdog/src/watchdog-test.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
> index fcdde8f..b3cc7aa 100644
> --- a/Documentation/watchdog/src/watchdog-test.c
> +++ b/Documentation/watchdog/src/watchdog-test.c
> @@ -23,6 +23,7 @@ static void keep_alive(void)
>   {
>       int dummy;
>
> +    printf(".");
>       ioctl(fd, WDIOC_KEEPALIVE, &dummy);
>   }
>
> @@ -34,7 +35,7 @@ static void keep_alive(void)
>   static void term(int sig)
>   {
>       close(fd);
> -    fprintf(stderr, "Stopping watchdog ticks...\n");
> +    printf("\nStopping watchdog ticks...\n");
>       exit(0);
>   }
>
> @@ -43,11 +44,12 @@ int main(int argc, char *argv[])
>       int flags;
>       unsigned int ping_rate = 1;
>
> +    setbuf(stdout, NULL);
> +
>       fd = open("/dev/watchdog", O_WRONLY);
>
>       if (fd == -1) {
> -	fprintf(stderr, "Watchdog device not enabled.\n");
> -	fflush(stderr);
> +	printf("Watchdog device not enabled.\n");
>   	exit(-1);
>       }
>
> @@ -55,36 +57,30 @@ int main(int argc, char *argv[])
>   	if (!strncasecmp(argv[1], "-d", 2)) {
>   	    flags = WDIOS_DISABLECARD;
>   	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
> -	    fprintf(stderr, "Watchdog card disabled.\n");
> -	    fflush(stderr);
> +	    printf("Watchdog card disabled.\n");
>   	    goto end;
>   	} else if (!strncasecmp(argv[1], "-e", 2)) {
>   	    flags = WDIOS_ENABLECARD;
>   	    ioctl(fd, WDIOC_SETOPTIONS, &flags);
> -	    fprintf(stderr, "Watchdog card enabled.\n");
> -	    fflush(stderr);
> +	    printf("Watchdog card enabled.\n");
>   	    goto end;
>   	} else if (!strncasecmp(argv[1], "-t", 2) && argv[2]) {
>   	    flags = atoi(argv[2]);
>   	    ioctl(fd, WDIOC_SETTIMEOUT, &flags);
> -	    fprintf(stderr, "Watchdog timeout set to %u seconds.\n", flags);
> -	    fflush(stderr);
> +	    printf("Watchdog timeout set to %u seconds.\n", flags);
>   	    goto end;
>   	} else if (!strncasecmp(argv[1], "-p", 2) && argv[2]) {
>   	    ping_rate = strtoul(argv[2], NULL, 0);
> -	    fprintf(stderr, "Watchdog ping rate set to %u seconds.\n", ping_rate);
> -	    fflush(stderr);
> +	    printf("Watchdog ping rate set to %u seconds.\n", ping_rate);
>   	} else {
> -	    fprintf(stderr, "-d to disable, -e to enable, -t <n> to set " \
> +	    printf("-d to disable, -e to enable, -t <n> to set " \
>   		"the timeout,\n-p <n> to set the ping rate, and \n");
> -	    fprintf(stderr, "run by itself to tick the card.\n");
> -	    fflush(stderr);
> +	    printf("run by itself to tick the card.\n");
>   	    goto end;
>   	}
>       }
>
> -    fprintf(stderr, "Watchdog Ticking Away!\n");
> -    fflush(stderr);
> +    printf("Watchdog Ticking Away!\n");
>
>       signal(SIGINT, term);
>
>

