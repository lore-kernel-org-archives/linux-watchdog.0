Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ED2C10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4032084E
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 14:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIlx4/Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDNOD4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 10:03:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38492 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNODz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 10:03:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so7321221pfo.5;
        Sun, 14 Apr 2019 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S5NbLZDXhkwJUj7G9aQSMrz++l0IpamyxnjZnm4CKr4=;
        b=SIlx4/EpMoftN3hR6Euv6O9rjqjUqiKNPdOtYMcLBuurb9lsKX/zsREXpRUA5EYBci
         F8nFBDHqbUYl07Qd3xrk7YxbTcury0fEBRLpEzHog3BORibPaT1Y8w/H5iJiDQv6VkOR
         v8u2lKMDikHcfRXjOubbL4Ke5st2SJxmBBRuG/GkhY2VCZJagr3gpwmFz9J+L8sCxde8
         ElmaSnB71CZ9/4o2/nj0M3QIJjMyRYf6pbQUxv7ARnAF+Bdw9GhSJis+6nuaBsJVkG30
         UJw07Eh4UcBFaFCEvU8iazo8oYJ2sqrCrJVhINu6OilYJZrPUL7hkpT5qcnCF9nKCdEy
         IpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S5NbLZDXhkwJUj7G9aQSMrz++l0IpamyxnjZnm4CKr4=;
        b=DFfNknTv4CspDA7FgjYi/XooLdX6MT115JBUx73KIdVtTMa4T7/7TNrNMWz5HXemsD
         fa7x9eJybPZE31G3KzWbCBCQ7ImI2hYWfmj3YzgQe6rUB1fViNj5GpE6BKTMs2SsiXUt
         XEBfDkKSgIsbIs1xecqswP3r3Tnq4YlLABpF7cVz/XiVddNJ1pv6Onz4gWmtFIUa02d9
         55gFZiDzFpKfEFjt75tgqCialBuEWRUINB7tEmymQ2ZqClMpju9lYD5wzxqi51WNhADR
         kNL3BUEZBzZTxwxS3n6+Tn76Ao31Md8maiTOp3CcqUwrv53S545rXAumbpTEMFyt2etf
         hGSw==
X-Gm-Message-State: APjAAAUpOiXBmfZcZhKP/uem+lEfibLQ9f4WqCqEiJOdd5DxiD68sR4E
        iI1qjJdckOyeHkvxMP0Quz5SMtib
X-Google-Smtp-Source: APXvYqwsBRYQGjwqnjHWwtap6pdrS7VL9mjbI7ESu9TPpd313XxfSgVCUfEhnq6ykp576j4/Qp1uCg==
X-Received: by 2002:a65:47c6:: with SMTP id f6mr64420438pgs.173.1555250634452;
        Sun, 14 Apr 2019 07:03:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k186sm64746381pfc.137.2019.04.14.07.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 07:03:53 -0700 (PDT)
Subject: Re: [PATCH 01/16] watchdog: refactor watchdog_init_timeout
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
 <20190414102627.5564-2-wsa+renesas@sang-engineering.com>
 <64e8adf0-cf87-3d54-4513-fd531ab7b7f2@roeck-us.net>
 <20190414134238.aj6c42pjj7xjbtxo@ninjato>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7007b01a-854c-67d9-66f5-e12d8c97afc6@roeck-us.net>
Date:   Sun, 14 Apr 2019 07:03:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414134238.aj6c42pjj7xjbtxo@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 4/14/19 6:42 AM, Wolfram Sang wrote:
> 
>>> The function is not easy to read and has two problems: a) -EINVAL is
>>> returned when the module parameter is invalid but the DT parameter is
>>> OK, and b) for the module parameter, zero is a valid value but for DT it
>>> is invalid.
>>>
>>
>> That was on purpose: A module parameter of 0 reflects that no module parameter
>> was provided, which is not an error. An explicit DT property with value 0 _is_
>> an error and does not make sense. "use the default", in the DT case, can and
>> should be expressed by providing no property, not by providing a property with
>> value 0.
> 
> OK, I can fix the code to do that as before. And add some documentation
> to describe that. Please let me know if it is documented already and I
> just missed it.
> 
The existing documentation is indeed a bit vague. Explicitly documenting the
expected behavior would be a good idea.  I keep having to explain how this is
supposed to work for almost every new driver. The most difficult part is to
get people to understand that the 'timeout' module parameter value should _not_
be pre-initialized with the default timeout but with 0.

Thanks,
Guenter
