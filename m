Return-Path: <SRS0=BWH3=RE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82967C43381
	for <linux-watchdog@archiver.kernel.org>; Fri,  1 Mar 2019 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2A20854
	for <linux-watchdog@archiver.kernel.org>; Fri,  1 Mar 2019 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOzolK6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfCACEa (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:04:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37029 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfCACEa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Feb 2019 21:04:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id q3so10671696pll.4
        for <linux-watchdog@vger.kernel.org>; Thu, 28 Feb 2019 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9H0vj3PiIETKxRL597W8TPePTE00LxaEuiYlO9doHp4=;
        b=BOzolK6QvLuIgMqaaflFhzwWeKSh02TbqKKz7GZqvEyn1f5jZshnAL0h/6vV3+xQ38
         WWDbWs+frrcfKHVyF/hIGz5clo9YfLNcR4jTxQnSbgIE6ACi3S+XwlJyer47Dtp7Ztsx
         Q2YvL8iYzPh0fgbLzxZy+aKCy0rp/4YiuFQn28u2MWdbTyW5SE7a9D6zZA2C5f74ZW20
         YyQhYxK15DV6SaM0mWnYekJWDlGcBcTHFUvNTksTNyJjrZA7eEAFo2rsXyaOxdykfUOk
         8q+MKoSuCQXmVpVkgnYDzw8eG7GOchAfJAs8cCGX1WaW+vdhSqKPVNOzGYXcYE+DDhz2
         wnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9H0vj3PiIETKxRL597W8TPePTE00LxaEuiYlO9doHp4=;
        b=OCSBW03Cw3VcbVgu0R7I8XO8kH07FwjVKaHifEEMB0aJjbdebiP/oIrauQ8ufI2NXh
         RC6ZTGhJeZR0DZWaaS+Zun96I6rcOKM/B2089OPte1ZQpq0ITL+NEIKomQkdbfYqZEXu
         bIbhAn4FagYBLDpWllJxZfvNeCKchM6XLxeSCLxDzg2d2I5lXfDVDSmi2qAuxLC3JX05
         yN2p55DujnHaN7UUHLflDJmENyq8xLUNfmwFp4LLYi3N/sXWXZ3zdwp51U6R6AP8H6tu
         aQjs8RqDq7HtLw3VGspt86VJNQxbvuhV7t2WVYw0nBFVBy1m7f+gQUMLCeabncAk0dR/
         QVKQ==
X-Gm-Message-State: APjAAAWzMhdnn2ttnNEPkVVYGDHm/5T1b6yetK+mv74MuUTUY6VnPdTu
        W74NiCi48LIcymhvVYgkssQ=
X-Google-Smtp-Source: APXvYqzwQ1AF//scYYzTV4YWnD75MRntGgquLRVXBi8ZOQ3t+ypyTEwqEd/BqsQSLGfXOSUOjnZYQg==
X-Received: by 2002:a17:902:7242:: with SMTP id c2mr2709905pll.245.1551405869504;
        Thu, 28 Feb 2019 18:04:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm31688235pfg.53.2019.02.28.18.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 18:04:28 -0800 (PST)
Subject: Re: [Kernel.org Helpdesk #69024] patchwork support for
 linux-watchdog@vger.kernel.org
To:     kernel-helpdesk@rt.linuxfoundation.org
Cc:     linux-watchdog@vger.kernel.org, wim@iguana.be
References: <RT-Ticket-69024@linuxfoundation>
 <4ae83727-d89e-5201-00bc-347b3a8cea0a@roeck-us.net>
 <rt-4.4.0-17515-1551397059-1845.69024-6-0@linuxfoundation>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b97e729e-f8a3-5625-3028-f157a212c71f@roeck-us.net>
Date:   Thu, 28 Feb 2019 18:04:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <rt-4.4.0-17515-1551397059-1845.69024-6-0@linuxfoundation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/28/19 3:37 PM, Konstantin Ryabitsev via RT wrote:
> On 2019-02-23 11:59:29, linux@roeck-us.net wrote:
>> Hi,
>>
>> would it be possible to add support for linux-watchdog@vger.kernel.org
>> to patchwork.kernel.org, with me (and possibly wim@iguana.be if he has
>> an account) as maintainer(s) ? My patchwork account username is groeck.
> 
> Would you need patchwork-bot integration? Please see here for details:
> https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration
> 

No, thanks- Wim maintains the primary repository, and it is not on kernel.org.
But I'll probably ask for it for the hwmon subsystem.

Thanks for the link!

Guenter
