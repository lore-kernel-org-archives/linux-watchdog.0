Return-Path: <SRS0=PQIJ=P5=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFCC3168B
	for <linux-watchdog@archiver.kernel.org>; Mon, 21 Jan 2019 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2C20989
	for <linux-watchdog@archiver.kernel.org>; Mon, 21 Jan 2019 17:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyvyAdhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfAURUJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:20:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfAURUJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 21 Jan 2019 12:20:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so10416750pfc.3;
        Mon, 21 Jan 2019 09:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRWu/ogsDuZJKnx7jxwA+hJHucPDkZL4AIJgsTbT6OE=;
        b=XyvyAdhJ0WGa/LIVqJi8ZWtNv6lkB3nFzbuEUDO6duQpmmyNDg+nkE9xFyjthx84r+
         qFt52qSqF+/Mq9XwBTR6h+xOPSAJsGBb+3JvdbKYA7/ZDbrDOVf47jNf20hngt74BX3A
         M5YuIPeZAdx3f4ozhDTt+nqhDvySxNT0AVCaruI+52hAoKgiCplHT0lp+mk4eXJvX4Ag
         D00dIMqANHr7HvoJ9v5g/Ex8/NKiMlQt5fuBxq2pvj/dfl6rJgf8rAF6zMwpDNiNrK3D
         JirGAAg9trmtvVBPn6sOmS8uWU08i34eNIXVdtne6a7wcxwsS4RU8OhzCqtA6wQI0NRZ
         x0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRWu/ogsDuZJKnx7jxwA+hJHucPDkZL4AIJgsTbT6OE=;
        b=m3WdnVxeqDZbPruPy6x1P4T541ff5EfEjcCPFZTnwLgYWQjUs6nYpRWx44ZPWX1ZxF
         L3fEZLa+Azoi6Wfxe6GQsrwM1xUkfMw9WNOjbP5xohZfQdd2RyzdypBUMO7mAvvsXAR5
         TZy/ZBjF8ncfxkX0OVvX3XP02peliVITJBOmoLGd5FcsiquENGpb14tzmExXaTtC2lCX
         G5P82hjyWM4VDnPDl9OUmhME44A7sSe2O4F+vwlgK9zTB8oRg/0Ctamy0FWORBHMzkNT
         occjnzYC92UKvFm0fZpSyMfKDEu9yM1geGOsVgNr39xrMmgGFk/bsyffKUIt/yrOJTSx
         Hr+g==
X-Gm-Message-State: AJcUukcGPqeNbwJxsdjQMZX2cxLl6qVCPnU+jVj4ZjbLEiuMU0P7e7XI
        KjtAorOIsurkWfYi2WkwKaamUxtB
X-Google-Smtp-Source: ALg8bN55urBaNbw+Csh3K7iKMyJ7YUcEjPhqQWWNWqPiTgW5dSp3d6YsnkH21NHKpuLDBECVSmyv8Q==
X-Received: by 2002:a63:3d1:: with SMTP id 200mr29091404pgd.68.1548091208241;
        Mon, 21 Jan 2019 09:20:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u123sm20600225pfb.1.2019.01.21.09.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 09:20:07 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document r8a77470
 support
To:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <1540544153-48098-1-git-send-email-biju.das@bp.renesas.com>
 <20181030135956.sofloch72mgsqi2o@verge.net.au>
 <OSBPR01MB2103273E3B91A5AAD68A08D4B89F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4b384324-a570-58f0-e985-63aa31e84bf8@roeck-us.net>
Date:   Mon, 21 Jan 2019 09:20:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2103273E3B91A5AAD68A08D4B89F0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 1/21/19 8:33 AM, Biju Das wrote:
> Hi All,
> 
> Gentle reminder.
> 
> Are you happy with the below patch? Or do you want me to resend  patch with the tags?
> 

No need to resend; somehow it is missing from my local patchwork instance for watchdog-next
and got lost. I applied it to my watchdog-next branch with all tags. Wim will pick it up
from there.

Thanks,
Guenter

> https://patchwork.kernel.org/patch/10657119/
> 
> regards,
> Biju
> 
>> -----Original Message-----
>> From: Simon Horman <horms@verge.net.au>
>> Sent: 30 October 2018 14:00
>> To: Biju Das <biju.das@bp.renesas.com>
>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>; Guenter Roeck
>> <linux@roeck-us.net>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
>> <mark.rutland@arm.com>; linux-watchdog@vger.kernel.org;
>> devicetree@vger.kernel.org; Geert Uytterhoeven
>> <geert+renesas@glider.be>; Chris Paterson
>> <Chris.Paterson2@renesas.com>; Fabrizio Castro
>> <fabrizio.castro@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
>> Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Document
>> r8a77470 support
>>
>> On Fri, Oct 26, 2018 at 09:55:53AM +0100, Biju Das wrote:
>>> RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car
>>> Gen2, therefore add relevant documentation.
>>>
>>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> 
> 
> 
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
> 

