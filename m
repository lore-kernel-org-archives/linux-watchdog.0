Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535031960B
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787886511; cv=none; b=Y/Mj789w1XivBxrnyhINg6J8X6XEPWIsGNwHtM5h15A+9dQFLmWrd9D+4eIc9Nf9CcaE1vA247oAI1LnyqdzlE21mMiyo1EttkUYIJ0+KXmHEJlB08NNTuUzGqnaMACIkNNVHPXtbuYaCUiGlhts+JKvaIm5dRut6MJ9c5eD7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787886511; c=relaxed/simple;
	bh=58MZnXqNvAUpTvQbAaqqCYU3pU8leK244U0vcP5a9HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMCpbGqudm2KcSHMX/97X07dPYIbUJCKIWLTELTA9lDHb4s21rM9Z2pmw/ZK6/7Z/KxJdjmYm3L5QNAoa0s8fe1JHBLmAsu+vQIztmdz9fnl14c0za72Gx2+vfP39KaHJwDFzrFGSQyc60BxE1xHhzYznpewBa+QgEWdwTF0QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo0D48i9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo0D48i9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso6319895ad.3
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787886509; x=1788491309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcCMs6Dmp6e/c61eU4qREyq4ydHiJTI5GYvkaDUBoPU=;
        b=Zo0D48i9JQaJTZAH5MvXl3DT4mNS4IMvSOhv2BKwaagGbpIINaHpXFfDQtjSRnK0kn
         16/yH6VvWm9EJ9bYNCCGxQeQRvYaS5snzI7Mhi7EQpOlYwXLLlXOV7d8CrFShvkoQQ50
         W3fbqh0w5DL8xDfWymZ6JUBLNzXQ0G99r9FtBcGq/hGpwHVyieQgPJyiLNiAHM/QZCuI
         ioyWugrYf2vK+dFh6uAcDigRNd5ChuzMuaAUOk2vRKUFpRj2F/J44z06/LuYPfGM7AEd
         3+u1bVDdnvx3+sc9Jq6p2Qfiezl5O3CoIL8wzoxUDfeqvtPkq6aJwRv7BNoFItwyzps5
         f8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787886509; x=1788491309;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KcCMs6Dmp6e/c61eU4qREyq4ydHiJTI5GYvkaDUBoPU=;
        b=jANBa4zFD/5Nv9h1yBHI+wM07I3aZ37bk/oI5Pt7L4594cSFY164/nunbvBxucYt+E
         +Z+SkZZ7UoIz+x5pHsYMJHqQxBc8KDVZr4bqj4GFrijIOqcFdHb74G55XcYxPYtCnHkt
         jn8AopZebcSR3FyVsvEHXF6I6i9lc21zqtjoaAwsjXO0k8CEFiz3t1e1ziUdvcYKYAGy
         /UM6M4TE9EzaDwd3ecAbistDpr467UpyDxyUueRHRGDh98+spU/zY8bBxuE8KCDQpuxs
         lR9Hw5gp/drBCULmOcw+8gXRb7JRqgnj40+EVBQgsvEm6SfPdJH59t4zsdzZPwMhppw8
         O/iQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmTbGzNUIY7AAHFcpA/omszlZVlGzm2a9L/M/cY1zSmEL5JYq7jqe4Zn4C2xLbhpGhEl92SbbSdK5k4JlngQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lgzAkOepDqH34kgC/h4KdvpA6AwgbZDsOGys0iSU0GEy2arsPo
	Q3J8vFRW5kZ1rVN5YxqtPZbH3imvkJX1X6xM+6dvBf24NrqvLGtmhSaO
X-Gm-Gg: AR+sD10frK2SSvnYhgpYoHN/2HgdJZClpJBd3u3Tl2JesMyRjWisuhzY+CM504q9ORm
	4N1sq8mAop4ARdIJkeHLCaPu+Yy6Rj85qmyvU6PhP/l0Q70EPFECgNN/qavP+E0U9QjQhqp93G5
	8A4rVVcmh658rmMk/0efwp7yqEt54Pzii6E/hgF2RH+XMPbNB73K6Lsl0xeW1xcFSjIBYUW7NNE
	67x1mAx5b/d5h/SeYFTQBFs9LEBWem2GCvA8hV9ZU72MNl2uuVScaLYvsMrB3zQJ/PLXS2FzXRt
	manutjq8516ZUPV8sreBk9w++yfRVHWw/oZYaP0FFTAqqlUxX/0RND0jpw2dVnjmawPrdKTxrYK
	+n8lVJH3DLmTwnr9Mprq4Jw92SysPDFPJGf9kGkHw7QcC0NlGi4mp96kg2qQsqLpEBpOfyizeJB
	21ssqwlh35m+yHsQZ3bQGVKsPnI23AZuF5qaHa5JkPgY4OvhqQ5a1rjT7WFuoqqkLN67ckjoHc7
	AqpiYQIrjlYYYLa80GgbnEyn5Amh1rW6vWR2A==
X-Received: by 2002:a17:90b:17c7:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-396d0fc1b2fmr7004791a91.16.1787886509555;
        Thu, 27 Aug 2026 20:08:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm926366eec.14.2026.08.27.20.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 20:08:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1bc0aeda-aa67-4541-85cb-752017f376eb@roeck-us.net>
Date: Thu, 27 Aug 2026 20:08:27 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: mediatek: acknowledge pretimeout interrupt
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wanming Gao <wanming.gao@mediatek.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wallace.yu@mediatek.com, Jarried.Lin@mediatek.com, vince-wl.liu@mediatek.com
References: <20260827092616.2724197-1-wanming.gao@mediatek.com>
 <5e1793d5-6c78-4372-872a-069fcd99a07a@roeck-us.net>
 <apDtp62h_4uZQ84H@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <apDtp62h_4uZQ84H@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/26 19:08, Tzung-Bi Shih wrote:
> On Thu, Aug 27, 2026 at 06:54:03AM -0700, Guenter Roeck wrote:
>> On Thu, Aug 27, 2026 at 05:26:12PM +0800, Wanming Gao wrote:
>>> The MediaTek watchdog pretimeout interrupt is level-triggered and does
>>> not have a separate acknowledge register. The interrupt is cleared by
>>> changing WDT_MODE_IRQ_LEVEL_EN and then restoring it to its original
>>> state. Without this transition, the interrupt may remain asserted and
>>> cause an interrupt storm.
>>>
>>> After changing WDT_MODE_IRQ_LEVEL_EN, wait 70 us before restoring it.
>>> This is longer than two 32 kHz watchdog clock cycles, allowing the
>>> level change to propagate across the clock domain.
>>>
>>> WDT_MODE is also updated by the watchdog start, stop, and pretimeout
>>> operations. Protect its read-modify-write sequences and the complete
>>> IRQ acknowledge sequence with the watchdog spinlock so that concurrent
>>> updates cannot overwrite the temporary IRQ level state.
>>>
>>> Signed-off-by: Wanming Gao <wanming.gao@mediatek.com>
>>
>> Applied.
> 
> Might be a bit late, but tested on a MT8196 board:
> Tested-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Never too late, really, unless I already sent a pull request.
Also, I have not pushed anything out, waiting for v7.3-rc1.

Thanks,
Guenter

