Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27E37C902
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772768; cv=none; b=B7wMgbspuWafGA/dWLooSEbrC5tnZ/vkPxmAXvjlJx1dQaEIvRG2nriSgtcq1o8DobPgNUqSvPy17ovhG/amX7AJpwrKBX21kRiPwzbL8q30A5WAUjh61gC0GH+rBg5ePeiRUXRsOYnPCkGjsF9qf7hVZvUQMvA1YI67V5VT90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772768; c=relaxed/simple;
	bh=3eWgsTeMNm/Ls+iLELS51O2oj79Tx3xVTJyCNM3Uksc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMVbIk5+3h113hhxbJ2fmXjCFz+HrfqajFelz4cXUVuw0QMMe5aO15UrCM1ctBNCJXLMzbX6F9JL7qLq5x+SG++IuSC7lbDS3wOHVA/HxgjMWjsRVZdDgWDDhzgTjDl6mBiz7ivMZ6p61a0W/ixpHjsGHl086uSOE/POn1DImBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntDHtyTp; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntDHtyTp"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0c955a481so467260eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 17 Mar 2026 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773772765; x=1774377565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=o57u90xFo+1xnHZkrNtm2PUXRZYXoIRXqLWYmrNPe3E=;
        b=ntDHtyTpywTXICas4xko7jwtAbcWBTO4Mo8IoZs5k8bboTbm3wgri9I3uftiwnd3Yj
         LFYVuLxYstSOs9xuvnkPWUnNGrt+CYb0ekErLI0vaF5s16nlXYYOd7Rht8cCgA1ArPd0
         cLC/ytOLLg/u4oRPtKL0S8A8r2sYfi6qQHJziXAFg/Y7lp9trFRx/Et00VDkwB2Zjk/J
         CsTePY3bRR1c+u/ZjbIIHS5SvIwe2eJ0WK1YeC+YtQTXqsu8nyrUdfECDIsi9Oe2RE8O
         Qfy3NxJYAXPJZ4B2VUcgYuBn8bd6fQiLNbb5+JrF/Zo6gaPUH8V5otI4d4agarK8Hz5w
         KiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773772765; x=1774377565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o57u90xFo+1xnHZkrNtm2PUXRZYXoIRXqLWYmrNPe3E=;
        b=LsEcKWcOIUp7gL7Q/TdrF+7l9ezUbMBCVkAd8eEh/sQ+yT6fIlFm8ar70PsJRbjMsI
         DcJgw3Oyof+O33EcLo9bDhVsn+c2MKB2tRJjVghhCsraZRsLjcq7FyJae+BdisnnQCcD
         wdMCg5IegVkcqV+JN3aEXwYpoyRu3DABSC9cgh86ZaVTdI/EXDCXRCVOwIdKJhRQFutO
         /f4iSgrmXnK+72t9HL2UHuflSQieSYlFLGW6Z4pJf0VKJ1+B2R1Aiyn6hIEg9grG8Dzs
         qblzp5i9ric7LQ5e3ZhmmUQT5JLG3DhpPFSZLIvzVaTfTGOJC0wAfwBgaFWMWzwFFhRr
         GAmw==
X-Forwarded-Encrypted: i=1; AJvYcCVb07czv0qt+TlguEWgmeukxlc6Xtap6/duBlQwadw/e70fcVhNTVztTnga7OgXCkr3bCRw6ZcMFpwuVFHcew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIGE7+dTD6SNhBi/EgxSD6+Hqr/x5lwFhn2AlbQRASEB7i7dR
	IRiExGlH/fb4d638dgttWIHiV0poJTpr5G0Fh/RVCRDaOLmbh16H0eaS
X-Gm-Gg: ATEYQzwzl712j4x4MrS2Jw+mjWFa6MLWy+0MIQLSNBYvrJcxbV+yRlHB08mU0PAYgFm
	bCcY2BSDldfletIykZMo3rUqgvcT2NCM5dpZMnPeP92hE2TAPe3SnC9htbkffyjiqYM6RE2f3+i
	aPWNZeY+bm05BXZXBV3+hXU1OxTK93Vw36usiQVk8v/DgLgkaVX3huML6/BwmwgCb/L0VwbmEsZ
	lMkPGpvVI4S9w5E6EOCu9Mn6sKOmn9tSh4nJ+8CwujgV1qffpli5HKEyyVe8i+VQokI/vYSDdOS
	ZXpOEGrEEgITPi5kW0PyfQulW/p7uIt2FcQs5QQnlGh7JI4tFZENHpwx1yvm+DOzMNQCqgwRt/Z
	EPCiYPYLdMzS4BGOR5eTFuzMdtFwl5z02pgJxSUYBFQtn4wEp3IRl67CRU+Gu4sG0HWGBSVpkAG
	bEdHqq+vDf79ufrPHtrc1Hsq7dR4Vs8BSncN+GFcn3KM2NeBvsoKBDldk5TGMAUbFqUU1aBkpl
X-Received: by 2002:a05:693c:2c06:b0:2be:833c:14a6 with SMTP id 5a478bee46e88-2c0e5044091mr324733eec.15.1773772765197;
        Tue, 17 Mar 2026 11:39:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ee672sm422387eec.28.2026.03.17.11.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 11:39:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <90d4f6fd-bc84-4ecb-b5c5-6c0a2a40fadb@roeck-us.net>
Date: Tue, 17 Mar 2026 11:39:23 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Refine hpwdt message for UV platform
To: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter
 <craig.lamparter@hpe.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
 Collins@owl.eag.rdlabs.hpecorp.net, Steve <s.collins@hpe.com>
References: <20260316214530.104344-1-steve.wahl@hpe.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260316214530.104344-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/16/26 14:45, Steve Wahl wrote:
> The watchdog hardware the hpwdt driver uses was added to the UV
> platform for UV5, but the logging mentioned by this driver was not
> added to the BIOS.  When the watchdog fires, the printed message had
> the administrators and developers looking for non-existent log files,
> and confused about whether a watchdog actually tripped.
> 
> Change the message that prints on UV platforms so it doesn't send the
> user looking for non-existent logs.
> 
> To aid in any future debugging, include all 8 bits of the NMISTAT
> register in the output, not just the two bits being used to determine
> this was "mynmi".  And provide names to the bits in NMISTAT so the
> code is easier to understand.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

The subject should start with "watchdog:". I almost missed this patch.

Guenter

