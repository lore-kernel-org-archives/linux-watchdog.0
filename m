Return-Path: <SRS0=AWpR=34=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E5FC35250
	for <linux-watchdog@archiver.kernel.org>; Sat,  8 Feb 2020 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6441217BA
	for <linux-watchdog@archiver.kernel.org>; Sat,  8 Feb 2020 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iliZFfld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHOWu (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:22:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgBHOWu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 8 Feb 2020 09:22:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1294726pfn.4;
        Sat, 08 Feb 2020 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GK86kXCsfmoEzp8e7PHMoIFZ5dmpQddgzx3iX22JpLM=;
        b=iliZFfld6Yb+NUC0MA9B2cyfEzrqjeK06ngz8vxLV16ctWDk3gmns2p3o2KQ8BsOqI
         H9eqDJE886ivcJiTDcnS3zkkdLUzEeoZf1INNiCWO6MTC0HAvo/12WttRWjZ40gAwIBC
         6Ku0hDZcg9xnMnriuNyLaudZ4sGK9lPPoyd9gRFWmUhpCnlKmrnFkKA4sqXq06kBE9Tu
         LX84D4+V/sHzKutUC66tOdr5uU5o+rgOz8ZuVAlR4GfEMFpUHoJhZpIC9diWnNyHSARy
         GER2q66yWClSGIYIZSaTxSwaUbqdrzj8Cz1yB31ET/W1yLT97crgxeAOTmqtMIVYiGuy
         FPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GK86kXCsfmoEzp8e7PHMoIFZ5dmpQddgzx3iX22JpLM=;
        b=ExQV+BbNGxUU+s5kJs5XOH2N8+2lqP963DxiULD2vsHBJ61BpZkZe/KW6DqfspjM7H
         ybWLCdMjJA20hiDxOgrTBA+fdbuktgIJrts/L7IT2yB344epm3QWv6CCcWrRazOjFKBb
         dATmsXIzm8rtoELGdpobih3e6PHZEnK9LtFVVLHI2wNcsS39ErQDT18DJ3VoMDmeZrLs
         X/T0IfquFnPH0gX7l6KMweGsAAeeIkroGVHuG7dpSJL0rokCOSodWhDX9te7Z3nRhvCF
         uZDXBa7vJpTWoO80tcFkarKK8IW45G1xPgaFoHh+HxIFCvbr4BbVoVc8Wl2o4KSPycKH
         lBtw==
X-Gm-Message-State: APjAAAXMCS4m/EnbLFlFNR5n+cpF33wN4YFrF6pXPZbW5y3DvvH2YdzT
        JQrhW+Vhv1OfRsGSDAtG6H0=
X-Google-Smtp-Source: APXvYqzCWX77jVrfooQQqkN9V85LOwhfpRQnd2YTW/1sVsyNKMDPssJ25kEykRqfo3OVptiVW1X0ZQ==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr4843324pgi.241.1581171769224;
        Sat, 08 Feb 2020 06:22:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2sm6589682pgj.7.2020.02.08.06.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 06:22:48 -0800 (PST)
Subject: Re: [PATCH] watchdog: da9062: Add dependency on I2C
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>
References: <20200208130803.23387-1-linux@roeck-us.net>
 <20200208140152.op4dplfvljosnlvb@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a02386a9-041b-a351-643f-ba0b6e91bab3@roeck-us.net>
Date:   Sat, 8 Feb 2020 06:22:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200208140152.op4dplfvljosnlvb@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2/8/20 6:01 AM, Marco Felsch wrote:
> Hi,
> 
> On 20-02-08 05:08, Guenter Roeck wrote:
>> Since commit 057b52b4b3d58 ("watchdog: da9062: make restart handler atomic
>> safe"), the driver calls i2c functions directly. It now therefore depends
>> on I2C. This is a hard dependency which overrides COMPILE_TEST.
> 
> I just wondered why it doesn't complain if no regmap support is on and
> surprise it provides stubs ^^ Is it worth to add i2c stubs too?
> 

I'd rather not go there. In practice it doesn't make much of a difference -
it just ensures that COMPILE_TEST can run on architectures which don't
support I2C. I think 0day only finds it because they select COMPILE_TEST
and then selectively disable I2C (and maybe other configuration options)
to catch problems like this.

Guenter
