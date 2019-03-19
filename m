Return-Path: <SRS0=C7Qm=RW=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D1C43381
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Mar 2019 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2922E213F2
	for <linux-watchdog@archiver.kernel.org>; Tue, 19 Mar 2019 00:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxDPbI2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCSARP (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:17:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42211 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCSARP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Mar 2019 20:17:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id b2so12516085pgl.9
        for <linux-watchdog@vger.kernel.org>; Mon, 18 Mar 2019 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dfzcwP8NhfJsBEbhLAyCl5Ga/xQT3LAP3ncNU2PHAyw=;
        b=GxDPbI2lK7DSPThSof08EzcNgwbNyHRb8ZflFT0w3QySlbt/nqKKwydMxUgAzkl3dF
         sN51gjHc/+sD4ts6W3cjzompHL+iVZ6jvR29n1eJE8msf8keAs/HBbUKMvcBy0WAMWje
         72VGkgmCe6KefFxPEskptRzv6pjU4X6qZxlpY08CSXZIRfjheMQlAaWuCN74zvr/TPL/
         EFvenhjytHkNvYqPwqIW7ueVxIN+2DEytIsEgkB51KeXXUVI44+JFcVHSz5d5Pr8/Ec2
         RKXaY+TIfCzF9DGzltCwOLdjMrcvnSZX5QEH0DaS1Zw5q86zwnDJnIflPrJJumhhsnIX
         DorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dfzcwP8NhfJsBEbhLAyCl5Ga/xQT3LAP3ncNU2PHAyw=;
        b=fhLFvvXynfY7VWc2lx14fhVVKxG/zXmACQ+7MaIC2u4l7blvhCjPp0XzL2mMNyoGSJ
         +6XbVvXHyBnG0EFeDQgoGjTC/D5z0obyiLBh2UoUjICiQlpSbNVEAor6TuJif+cb8AMo
         cCIDCCmiN8KPNsE1P/AUvIjN3lQ7NRS4IM/2Ph/Q5S45dO3fFaMHMsDaEuRZ44bsmxeb
         VxYM8w9v8Oe6d9CbxQXFQUcvFlt2vHy1yiW0oMwsi+thcgNe1h9wFL1qAM2HpBwyET8w
         o+wShEv3jskTU6LbJa9FR8Fyvh1we2AD4hIciKOQ728bErXuVbkMFBBVvspn+3FU140z
         X4hA==
X-Gm-Message-State: APjAAAUz50kFJxIGB8axu+9PaEujclG8ggC3L4zvmBBxHlhqIvlLWUiJ
        eP95W4ikj0UPFYc4JioLosAjnuaV
X-Google-Smtp-Source: APXvYqxpzEacFY10uycx2HsHpRKHmVqrxrmOQkQ7K5jdwMxfgJWmNVSz4eLJVB5FtfFoQpt6JZSYLA==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr19775161pgi.135.1552954634235;
        Mon, 18 Mar 2019 17:17:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm21738822pgk.22.2019.03.18.17.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 17:17:13 -0700 (PDT)
Subject: Re: [PATCH] watchdog: i6300esb: stop printing kernel addresses
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20190318011915.32442-1-mcroce@redhat.com>
 <5998d284-c714-0f46-ea3b-53cc8bf32a9b@roeck-us.net>
 <CAGnkfhzN_iutkyo5QAC8xTavpA=W=vG6VZW+b5nD1m+3PtiLbQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5ace654b-aa61-5799-095a-84fb7adcfce4@roeck-us.net>
Date:   Mon, 18 Mar 2019 17:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAGnkfhzN_iutkyo5QAC8xTavpA=W=vG6VZW+b5nD1m+3PtiLbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 3/18/19 4:53 PM, Matteo Croce wrote:
> On Mon, Mar 18, 2019 at 3:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/17/19 6:19 PM, Matteo Croce wrote:
>>> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
>>> i6300esb prints "____ptrval____" instead of actual addresses:
>>>
>>>       i6300ESB timer 0000:00:03.0: initialized (0x(____ptrval____)). heartbeat=30 sec (nowayout=1)
>>>
>>> Instead of changing the print to "%px", and leaking kernel addresses,
>>> just remove the print completely, cfr. e.g. commit 071929dbdd865f77
>>> ("arm64: Stop printing the virtual memory layout").
>>>
>>> Signed-off-by: Matteo Croce <mcroce@redhat.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>>> ---
>>>    drivers/watchdog/i6300esb.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
>>> index 950c71a8bb22..e312a2aeecad 100644
>>> --- a/drivers/watchdog/i6300esb.c
>>> +++ b/drivers/watchdog/i6300esb.c
>>> @@ -328,8 +328,8 @@ static int esb_probe(struct pci_dev *pdev,
>>>                goto err_unmap;
>>>        }
>>>        dev_info(&pdev->dev,
>>> -             "initialized (0x%p). heartbeat=%d sec (nowayout=%d)\n",
>>> -             edev->base, edev->wdd.timeout, nowayout);
>>> +             "initialized. heartbeat=%d sec (nowayout=%d)\n",
>>> +             edev->wdd.timeout, nowayout);
>>>        return 0;
>>>
>>>    err_unmap:
>>>
>>
> 
> Nit: can someone add the fixes tag before merge?
> 
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> 

This isn't really a bug fix.

Guenter


