Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CD78F3A
	for <linux-watchdog@vger.kernel.org>; Wed,  6 May 2026 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043237; cv=none; b=bPO77xn1gfmxXuYaiCvIfexXs3a6UM4uwnUIzWCZ9Co//BAAWu/hG/ZrJ9LCMObo8jJCEb5hsHAVlkl9r6d1Sz/gWczUgGaUzFh600yFVr4vjA/0Oyi39pzeHi0ZlCIHlSScm6aLpKsmcUNnewZ5YSxPm7luqKSpcPzhIRwukTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043237; c=relaxed/simple;
	bh=kGPExLM9k7Om92sbLJDAmHuMKkrOhILjpsQZoaHl1Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjNjajKY9cAdX/UxuQ6tEuilU2xiLvrz/W1CUTenP+yNDg4RpnjIOf/Bwy/OtKD2YZ7bu0zSmS9ZkPsF4Vf036x825d5kIW3y9ZP62INe9+70n+iz4iYyrFN8iCxZK7kMBGjEkBctqCyBqqffvUYS8nt2ZZ5ulH7XBF7WX8P4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd18Ne3e; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd18Ne3e"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f0ad52830cso5133462eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 21:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778043236; x=1778648036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lEMg+VknlRDghrp8zKkq6kI33OrjztcbWF59KQ+QOvw=;
        b=Jd18Ne3evJ0yhrd29x/XOO0BTE0mvYZylXhW0H12Vu6kNidYzzKhKSxhqNSQRlQDug
         XiGFDGcOa9GC3ijssAfxNPtfTUwi3XkC9XebrLfie8WNPEvYFcPNiFDTBDhAkmBhe7Zu
         YFd4knw7ZeheiWg6zf3LQBDba+LkPjb9GvRsGUFHYwTgI/MDDvP+EXrfa25bttasnSz1
         6gXrvZOIDyb9kg+9xi5GsMgzZQucOiRnxXbuggwg4iuBrJ08H3BvmBAyiwKyO608tWzZ
         bX8uAaljcdEjsiRwcEbTuFi/pcu4vmlyIx4Vl6g6scQ5eCEsXPlEKgYDtJobKDXCKCpK
         SN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778043236; x=1778648036;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEMg+VknlRDghrp8zKkq6kI33OrjztcbWF59KQ+QOvw=;
        b=XmgTlwK1wDvfN6va0ijJQLUJo5st70UnJ3kq5eqbW7mkCUwrGiBA8Fwn7xjE1nxX+Q
         3izLPnlwkakT+FRzIJ5vpp+CKFxDm2XXAHoCzFvUL1unWBLJ31liuzFemBhDazfiL7mg
         aXHcJROxyQrj9cU4XuI32gFcV/P/KU7QTHxH1SFe38GZX+8sfblIkBYDDPW4cW1yLtmz
         Krv+oOSNn92kCRtXsNGFCDzPZ/bsFCYQWBSfLCkkY40UZIlTedAnVYcRdfj06z5MPPwF
         AzFOQqd8lmskSGcYq2R5VkLOIqPIgnHMfHbxXdjnqIFS9Z/QsNBPwC4pl9d78IXVVgU1
         Of2w==
X-Forwarded-Encrypted: i=1; AFNElJ/PX8gOIk8F9M3T456ri+s3/a8tWbH3byaAUZb2k9K3Gisuez3SJNALcviNNnc73F0pzmIPnwxt353znsJQcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxD5px1AFYX2qmZo8QCT+L2bYwKZbu/Hli+FeMLFuyEHWIq37
	0Zjv0SPZSeyFXUWmJFRXohSzq24DZZp1YXomIK29vTsTapA+Tt2C1179T+tzNw==
X-Gm-Gg: AeBDiest8W8C8SpNwp15RA2JPDhU5MHCOh4BoNashSGis/6Y1fvnJcs6yb62Se6XPNI
	PtU/ZLGWzWQwS9LjxBiKpDXUj+4kjz4ElQL+V19fLxdg2C13Ym3FQy4QhYLztp0wUqpxKr69sZ/
	h629KvqRmebtIRIF4lMvnqL6LirvGJ4kqPpB+Wo56Mw/Ua/BTAvRhexOb2o8qINbKpribzaq/Lp
	nCPmdNcC7IXQPDM92JtFVJB2I34/sdobbtQsIZyC2OI0p/IdKgEWKMNOp/BKNKgc/2I54QnJPpB
	N21PZSEdDClfGWxys7RCuzA2KGtV9thoo5jZ4lSgC2/LGw6k2b7cL4J1aEpVCZirfo2s0t/SPch
	OjT11tAMAXXkBNQTtosiAM4y/wrIYi2eEKUTh2ZhR2bA+F5upCY9igcNfm0/gnQa0LbA5U8kf0h
	FG/75FmSxDvZ8E4cnpye8t3AAYRoO0IT2qbDeESzoGeq/+Fayir8mbYEMnkGTpAjGD7HKiNnH7s
	oAVtLFWf3w=
X-Received: by 2002:a05:7300:e78d:b0:2dd:2d70:8aba with SMTP id 5a478bee46e88-2f54879f1f6mr918059eec.4.1778043235552;
        Tue, 05 May 2026 21:53:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f891a56sm2085662eec.14.2026.05.05.21.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 21:53:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <81a90b2d-8dc3-4466-92d6-936679e210d5@roeck-us.net>
Date: Tue, 5 May 2026 21:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove driver for integrated WDT of ZFx86
 486-based SoC
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
References: <20260428014806.35400-1-enelsonmoore@gmail.com>
 <CADkSEUij01xaqNeFxHX3PRsFCWK7-m2eGH2Knt2T349QOzrQDA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CADkSEUij01xaqNeFxHX3PRsFCWK7-m2eGH2Knt2T349QOzrQDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/26 21:24, Ethan Nelson-Moore wrote:
> On Mon, Apr 27, 2026 at 6:48 PM Ethan Nelson-Moore
> <enelsonmoore@gmail.com> wrote:
>> The machzwd driver supports the integrated watchdog of the ZF Micro
>> ZFx86 SoC, which contains a 486-compatible core [1]. Since 486
>> support was removed in commit 8b793a92d862 ("x86/cpu: Remove
>> M486/M486SX/ELAN support"), the driver is no longer useful, Remove it.
> 
> Hi, Guenter,
> 
> Would you be willing to merge this patch? Unlike the other drivers
> whose removal I proposed, this one can't be used at all now that 486
> support is gone from the kernel - no other hardware contains this WDT.
> 

Already done.

Guenter

