Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6732C4338F
	for <linux-watchdog@archiver.kernel.org>; Sat, 14 Aug 2021 19:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9973760F92
	for <linux-watchdog@archiver.kernel.org>; Sat, 14 Aug 2021 19:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhHNT5R (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 14 Aug 2021 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNT5Q (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 14 Aug 2021 15:57:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CFCC061764
        for <linux-watchdog@vger.kernel.org>; Sat, 14 Aug 2021 12:56:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r5so21052654oiw.7
        for <linux-watchdog@vger.kernel.org>; Sat, 14 Aug 2021 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRfwNgrD75JLYmXwUCtNm9bkZCtiGwp3ZGULtH2XEO4=;
        b=lQry2peiAvYsJLE7aDmAKfikUFAOe7vLpHS2u/LJqnvVVu5sg9BjZ5DuI4efajI+iY
         1Ay+38DqTSMM7Nfog5kLcTQ5PvwqyTLGkUPh9hXIzObRvWG/6Y5C+bZUcw3bjHFfix31
         rQpocdn4X9K/wGL1XdZHVH5SuGTbyPhni/eN3nEcqxgp8pkjhvssjqNK9XwBX+uObXE4
         qqX6L/eG9hXh5tCTgTsUnG1GhgD8Bi4CwOsCPUWTpLcJ+ArMpyqCPYLVKPcYW37PpeWX
         HJQKsO4Elm86JOrmLuY5dzdrEbomAJ6K7V9l4nbfwRoQjV5Z/mXi6pbF+6nVmZoXHnzq
         3k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uRfwNgrD75JLYmXwUCtNm9bkZCtiGwp3ZGULtH2XEO4=;
        b=grDY3jV0oc1CkQ8/N2SE43EpzNzI7d8hblg0PemR2axPKhduwp8g2TlLVz9nwr/35Q
         37MOHIwIXDZC06l3pav7vMNgFavq/XvSc1Ie6kELOIV6I5gWD26C9L2W+yRt45F5P+9m
         5IbenlaNh6kCwOMribC5cBdqk2OCpIHvlM6fklFO7OAJrwvsmHg/Pw1NkPmuD1pH6zEV
         5F3yoODjT8KAKAuTFdQbOdqQpzLZiMxAfz4LxaKgYeUiZbLioX74YSXJOrZfb0YM8Nrc
         aTvISg2uywFsWrZcCEaSB/u+Bztif7lsNJ2/LgQN78ca61ErO7THFzDN9I9WN3d2JbFj
         5iZw==
X-Gm-Message-State: AOAM533xjs7bp5iHUcLIaP8/cKLFBmy5sUzmuf1kqYu0RT5NTiBAV9+v
        7OGrhvNVpOZR14vJ4jLDNVA=
X-Google-Smtp-Source: ABdhPJwyV5fd6zsa40uJADmxGsrlpE1atAPhrIqS2ewDjytgVbTqMWSKV9/1t4xiYjHbQpvj+PwYlw==
X-Received: by 2002:aca:5c57:: with SMTP id q84mr6480107oib.159.1628971007710;
        Sat, 14 Aug 2021 12:56:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6sm1190325otu.16.2021.08.14.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 12:56:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 14 Aug 2021 12:56:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stanislav German-Evtushenko <ginermail@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: Device must be opened for writing
Message-ID: <20210814195646.GB3951799@roeck-us.net>
References: <20210814191345.27221-1-ginermail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814191345.27221-1-ginermail@gmail.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sun, Aug 15, 2021 at 04:13:45AM +0900, Stanislav German-Evtushenko wrote:
> If userspace opens the watchdog device self-feeding stops. Sometimes
> opening the device happens by accident, e.g. by mistakenly running grep
> recursively in a wrong directory which leads to the server being reset.
> 
> Watchdog device does not handle read operation therefore the issue can be
> prevented by requiring the device to be opened for writing:
> 
> - Prevent opening the device without FMODE_WRITE
> 
> Signed-off-by: Stanislav German-Evtushenko <ginermail@gmail.com>

NACK. That would be a major undocumented ABI change. Opening /dev/watchdog
for reading can be and is used today to test a watchdog.

Guenter

> ---
>  drivers/watchdog/watchdog_dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 3bab32485273..28b88542a4d0 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -835,6 +835,10 @@ static int watchdog_open(struct inode *inode, struct file *file)
>  	bool hw_running;
>  	int err;
>  
> +	/* Must be open for writing */
> +	if (!(file->f_mode & FMODE_WRITE))
> +		return -EINVAL;
> +
>  	/* Get the corresponding watchdog device */
>  	if (imajor(inode) == MISC_MAJOR)
>  		wd_data = old_wd_data;
> 
> base-commit: cf813c67d9619fd474c785698cbed543b94209dd
> -- 
> 2.25.1
> 
