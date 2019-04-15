Return-Path: <SRS0=8G6l=SR=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CFEC10F0E
	for <linux-watchdog@archiver.kernel.org>; Mon, 15 Apr 2019 08:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B414B20674
	for <linux-watchdog@archiver.kernel.org>; Mon, 15 Apr 2019 08:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="QrFlyw70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfDOIVT (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:21:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38468 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIVT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 15 Apr 2019 04:21:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so3042677lfg.5
        for <linux-watchdog@vger.kernel.org>; Mon, 15 Apr 2019 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjL0XQZG+HyQuEEfM7wCFA0sYmyyrpsrVEapUZBj0IA=;
        b=QrFlyw70ZCUAQO+P1V035NcAlJ4UqdoVCU5BeRXuOcBdo37kXFVeX0I2QXKCgIX5KH
         Z9P+IMGrgbIynDcP/KZ069NcIfunox/HeL+156iKvXhI7aaoZUpuQzvjEjLGxmZaZxKG
         N1YNbqOobTmEuObyP5pgrqIImcrxc2zuHJhxwPYmOc7t7z2sA/Y41b2RgMH97NGRhEnW
         BzGOaEmAoICrui4Nrqb1SEsIN1LiQmtvQioCnyfhO5ydjtlp6jfa0PoUb0aWsg/UoQuv
         vXEm5C92KMvjNKZTtH9qSWvvvAXVZqQMR3OtqXQ/xVslgNkfPslfEdPSHeGG/yWf0566
         YqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjL0XQZG+HyQuEEfM7wCFA0sYmyyrpsrVEapUZBj0IA=;
        b=ulmVEK/+jwpzRgmvey5a9Kb5iDdUt21vhmbm/BvJQ/ihb/td8i/YhrcuEmtv7Up5wZ
         fz4LYaO+jbV7NgdqhXiLTS+hLIY2BmXa3w6P5E7HtlItuOV6VjXatA2/k8nnnfSTpxP6
         UFOPCRLXcJBOnw7TDWZlCFIetKj562EiqzGiFYOYkHWnRoQuOFfC/FmFexBb/p0NLjmK
         bgD9TQA8Z5e23s2Z660cZz7Io9JpKpuMUWycFWXgM1KM8IDqzHczi1X3/v7CmGB3JtF8
         yAOObKAVjT14+Ooen+8X3JdARWMJkIpoJYE84HeRR8v0i85XznT0BK6CTD7IKyVTMgY3
         Y7mA==
X-Gm-Message-State: APjAAAX0u6ZBtcxCv6mMta7YwvIwAPk+ikLHBEXXMwDHWuenBg6kd5eD
        UtmVTSr0Q2z3hJUghSnmYhklkw==
X-Google-Smtp-Source: APXvYqxNK7vvrZC5xsx390Bmid1rvxsEWxUvKTTDlbBjI1TCsDhQkUnqt1xqZa46bE1RP8nfZqQIcA==
X-Received: by 2002:a19:f801:: with SMTP id a1mr18651473lff.150.1555316476990;
        Mon, 15 Apr 2019 01:21:16 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.43])
        by smtp.gmail.com with ESMTPSA id r2sm9852302ljd.16.2019.04.15.01.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 01:21:16 -0700 (PDT)
Subject: Re: [PATCH 01/16] watchdog: refactor watchdog_init_timeout
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
 <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <35407697-cbbb-e72b-7aed-ed84a3beb669@cogentembedded.com>
Date:   Mon, 15 Apr 2019 11:21:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hello!

On 14.04.2019 13:26, Wolfram Sang wrote:

> The function is not easy to read and has two problems: a) -EINVAL is
> returned when the module parameter is invalid but the DT parameter is
> OK, and b) for the module parameter, zero is a valid value but for DT it
> is invalid.
> 
> Refactor the code to have a the same pattern of checks for the module
                             ^^^^^
    One article would be enough. :-)

> parameter and DT. Further ones can be easily added in the future if the
> need arises. The above mentioned problems are fixed, too.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[...]

MBR, Sergei
