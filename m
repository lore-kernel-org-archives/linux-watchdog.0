Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43793 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQURc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:17:32 -0400
Date: Sun, 17 Jul 2016 22:17:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/watchdog: add support for magic close to watchdog-test
Message-ID: <20160717201731.GB866@spo001.leaseweb.nl>
References: <1466550015-14924-1-git-send-email-timur@codeaurora.org> <1466550015-14924-2-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466550015-14924-2-git-send-email-timur@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur,

> Some drivers have the WDIOF_MAGICCLOSE set, which means that applications
> need to write 'V' to the watchdog device before closing, otherwise the
> driver won't stop the watchdog timer.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---
>  Documentation/watchdog/src/watchdog-test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/watchdog/src/watchdog-test.c b/Documentation/watchdog/src/watchdog-test.c
> index b3cc7aa..c691539 100644
> --- a/Documentation/watchdog/src/watchdog-test.c
> +++ b/Documentation/watchdog/src/watchdog-test.c
> @@ -13,6 +13,7 @@
>  #include <linux/watchdog.h>
>  
>  int fd;
> +const char v = 'V';
>  
>  /*
>   * This function simply sends an IOCTL to the driver, which in turn ticks
> @@ -34,6 +35,7 @@ static void keep_alive(void)
>  
>  static void term(int sig)
>  {
> +    write(fd, &v, 1);
>      close(fd);
>      printf("\nStopping watchdog ticks...\n");
>      exit(0);
> @@ -89,6 +91,7 @@ int main(int argc, char *argv[])
>  	sleep(ping_rate);
>      }
>  end:
> +    write(fd, &v, 1);
>      close(fd);
>      return 0;
>  }
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

