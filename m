Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E7C10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8452020684
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIzcGzlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfDNOwR (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:52:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35197 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfDNOwQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 10:52:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so7331437plp.2;
        Sun, 14 Apr 2019 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IpjI1Im0rR5x/hsUVfOIsJxHKqPB78JFgluvIryEN8M=;
        b=fIzcGzlkh50/kBqZTynji8FA1WzIs1h2yR9cRFzWSZ9xmrsr2pP5M2QgeT3kikOvRw
         P+sQOu4oamn5Gyvdsz6RiOdt73u8VIV4wBM75G3g/P8rp6uPOQ4U+ztiRiph9XQTu6LH
         /lyQm+30I9dVTGGOCd1wKRQ+1H0sb1CEyDwcHsJt5Qd9sQOSD/SM5Uy19rfbpygc+DRl
         /weNMd+gZo0ByIe8WU5Z78YgGod89psvIE7TFJAW/fgi6hPNwrHJOAAAMfn+zbqgnZ+N
         B1CUGzedcpqpEcUCKHQFJcRJa1RT6uElzvGs9nZBjRvLNkDmSuS4es9+aE4O9H4+TxeT
         gk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IpjI1Im0rR5x/hsUVfOIsJxHKqPB78JFgluvIryEN8M=;
        b=mmgkU7INGdzwt+j7zyK6GRfLdm0ylXPi2dnt9tbfpmYEQewq3zQRb85vowY+0qKAW9
         pOv00mivbA1rl1r+EO6RYX98zdg3qnZuRjAxxKq9PtHRgfBuofZhWhTQrG0O2vNA7Frj
         ICHXThUHS08sPYGP6LI4RgMP4oBFfCM/mzASVekDaVpJDOl1gyfWdUdME08THXe0GW8Z
         TWwe9AusSzbOrLnGQQkvTWK6xwM33he01w+3l5sRJYww19Kpn7OY3Zad/W6JX28YFTB4
         WTakKfIoERQbttjTxkWVOLGP2J8Lm1n/2mOx7/3bciZq5Gj/XQr6UJdRVdss2+w2wDL5
         3Wyg==
X-Gm-Message-State: APjAAAVmCupdgIuQHo/AXpYNvOiw5sdpLEb8ELAW5A2J+C1f3axPCQCA
        ko1PfTr6oK0lyOcskYysnU+qS89s
X-Google-Smtp-Source: APXvYqx01RQia+5OWLbjhS+2aCm02KoMD5cxX9s4cq8prk5MPCQ2HVWZC3+DpVu6900Pxa+qjyZBOg==
X-Received: by 2002:a17:902:168:: with SMTP id 95mr67932223plb.212.1555253536221;
        Sun, 14 Apr 2019 07:52:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15sm45990859pgf.18.2019.04.14.07.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 07:52:15 -0700 (PDT)
Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9fcd483c-07ae-b89d-d244-82151d03a433@roeck-us.net>
Date:   Sun, 14 Apr 2019 07:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/14/19 4:09 AM, Wolfram Sang wrote:
> And make sure the final obtained value gets properly scaled. Remove two
> empty lines to group the initialization blocks while we are here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Tested with a Renesas Lager board (R-Car H2, DA9063AD), checking the initial
> timeout value via sysfs. I didn't test handover from bootloader because my
> bootloader neither supports WDT or I2C out of the box.
> 
>   drivers/watchdog/da9063_wdt.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 06eb9070203c..3d65e92a4e3f 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -208,18 +208,20 @@ static int da9063_wdt_probe(struct platform_device *pdev)
>   	wdd->min_timeout = DA9063_WDT_MIN_TIMEOUT;
>   	wdd->max_timeout = DA9063_WDT_MAX_TIMEOUT;
>   	wdd->min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
> -	wdd->timeout = DA9063_WDG_TIMEOUT;
>   	wdd->parent = dev;
> -
>   	wdd->status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>   
>   	watchdog_set_restart_priority(wdd, 128);
> -
>   	watchdog_set_drvdata(wdd, da9063);
>   
> +	/* Set default timeout, maybe override it with DT value, scale it */
> +	wdd->timeout = DA9063_WDG_TIMEOUT;
> +	watchdog_init_timeout(wdd, 0, dev);
> +	da9063_wdt_set_timeout(wdd, wdd->timeout);
> +
>   	/* Change the timeout to the default value if the watchdog is running */
>   	if (da9063_wdt_is_running(da9063)) {
> -		da9063_wdt_update_timeout(da9063, DA9063_WDG_TIMEOUT);
> +		da9063_wdt_update_timeout(da9063, wdd->timeout);
>   		set_bit(WDOG_HW_RUNNING, &wdd->status);
>   	}
>   
> 

