Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34768 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGNer (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 09:34:47 -0400
Received: by mail-it0-f68.google.com with SMTP id c5-v6so11087661itj.1
        for <linux-watchdog@vger.kernel.org>; Mon, 07 May 2018 06:34:47 -0700 (PDT)
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
To: John Crispin <john@phrozen.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
References: <20180507131642.11440-1-john@phrozen.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
Date: Mon, 7 May 2018 06:34:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180507131642.11440-1-john@phrozen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2018 06:16 AM, John Crispin wrote:
> If the userland tries to set a timeout higher than the max_timeout,
> then we should fallback to max_timeout.
> 

We don't do that for drivers using the watchdog core, so we should not
do it here either for consistency.

Guenter

> Signed-off-by: John Crispin <john@phrozen.org> > ---
>   drivers/watchdog/ath79_wdt.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index e2209bf5fa8a..c2fc6c3d0092 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
>   
>   static int ath79_wdt_set_timeout(int val)
>   {
> -	if (val < 1 || val > max_timeout)
> +	if (val < 1)
>   		return -EINVAL;
>   
> -	timeout = val;
> +	if (val > max_timeout)
> +		timeout = max_timeout;
> +	else
> +		timeout = val;
> +
>   	ath79_wdt_keepalive();
>   
>   	return 0;
> 

