Return-Path: <SRS0=mrOV=Q6=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF1C43381
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 16:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369420657
	for <linux-watchdog@archiver.kernel.org>; Sat, 23 Feb 2019 16:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkDYBXB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfBWQ71 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:59:27 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38374 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWQ71 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 23 Feb 2019 11:59:27 -0500
Received: by mail-pg1-f178.google.com with SMTP id m2so2541192pgl.5
        for <linux-watchdog@vger.kernel.org>; Sat, 23 Feb 2019 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XldVy0TruuYmPfwrRGhsmdwo6M/cYqNUcNf5mTQwHW8=;
        b=nkDYBXB8nji4TvmoYjo1v9pkZD9ArsVZ4W5fXYGYBu8iR+250SHztgZGXdxn0dnHh/
         Z8VNabnWCW0Mq+HOpzbyFXHlKXt1TlXxl4aPV9MGYvBTB0VLCQc/p+vP6bzSRo/gObI8
         dOu47SPGPxsTJnM+WTA610zIhGuWKgLDnlC6IEuGPNYBp4CEo3l+1eqm0yebjK09BRWc
         ry84UztvmM99W/J3Uw73utKy++Aqo/yEE2Qkq2AciAItIVT158A/GUE2LZADeGLu4S5D
         Mxqq8E9bM6Ag+km/4eJ2ievt3fSY2vOfdCMBzBQqi/j02LvxrilxngHeko2QoYpQlTm5
         AsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=XldVy0TruuYmPfwrRGhsmdwo6M/cYqNUcNf5mTQwHW8=;
        b=hv4MLbH71knKzvzu7+6pzxSHvWdZfH5WgtWzWCxEwaFK76OqlhH1GY7NBbwCV9jPcM
         kIwf8oWLKikMr6TgutGn+o6r0EiEXjJ0eKFk/CQhwVCcoqNg6L2qm5XNhTV1AY9BFOyT
         dzyDRcT4kD3FAgibh9HC/h4XYrjNW0GzohP7voDhps2CVEdiR/AGR0lP4uUSQnwqsTqd
         0hdrGgZ+MxIzlwY4Uh3hhKOyRlzV5Qrp5afc7cPukjxksRGGjsaa8z7KPSmX4jm8D5II
         U+XLmsGontRDeCAHeFab96eU/oi7XytW2Hf+TC5EauofIcEBzPsong2lJZD2XQ76ulRM
         TkpA==
X-Gm-Message-State: AHQUAuaiW676x1lNUmnDJ2JJf1xVGDtSZo49uJelKtwH2ubshOJiaBFh
        nUs5eSTb6PEHfhdZMB+C7jZTwzpL
X-Google-Smtp-Source: AHgI3IYULpRvdd40Y9r/4/Lq0mW/dWK/pE5A/8zNsdrHxsUSTO1CCfkbiY3f+A73zrzuIXn8FKZK0A==
X-Received: by 2002:a62:1854:: with SMTP id 81mr7787338pfy.223.1550941166627;
        Sat, 23 Feb 2019 08:59:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm7810116pga.92.2019.02.23.08.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 08:59:25 -0800 (PST)
To:     helpdesk@kernel.org
Cc:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        wim@iguana.be
From:   Guenter Roeck <linux@roeck-us.net>
Subject: patchwork support for linux-watchdog@vger.kernel.org
Message-ID: <4ae83727-d89e-5201-00bc-347b3a8cea0a@roeck-us.net>
Date:   Sat, 23 Feb 2019 08:59:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

would it be possible to add support for linux-watchdog@vger.kernel.org
to patchwork.kernel.org, with me (and possibly wim@iguana.be if he has
an account) as maintainer(s) ? My patchwork account username is groeck.

Thanks,
Guenter
