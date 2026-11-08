Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140294;
	b=YHZWkCDmhhqdSnTozJ61sEdqQNQHQNvkGcCcsRN3+aNDJc+cwoKmp/AdKRQSOe3UEKnd
	 I8WTAsu6wrXlw6J9Puj2YVKmEaa7l4f/b3ijslc2v9OduY9unrTPvDHoXt3+/pKzLzD05
	 tbHO42PQQ9tvZu4cw8rhC1HCGsUlrEuETS+YLScDw1FbZ6uh2b8L74uXVy+SYxJYtKCH6
	 ifHzmxEw07DwPDvgt16s3fuFDBJ2yAtOEO7qSr0Jer87/lZSPeo11dE6pUrGqf6l23N1S
	 UyFaXYZ/f+2Qc/O9YnGy2BIcTBpxiKEG3huPOxdraFdMr4f35IiuQObg8ztc9OxspHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140294;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=9dxS43q9INEr00hXjKs419HaTH9a5Xai1L8wRnr7cRo=;
	b=AzP5LA0LV5ezV06oRuu/kRJldXyiWv+jcUR3MoNvwhzd5oS1AlD3IgvOxtARFoly7rqt
	 febAnQVYIjTJP1INIc2xMuXVwq58fJYbSWzH7lgOXbJc92yiNAe8CJD1IU4eTmoeBAKaj
	 hg3GyWglJ0L1zwdTssKpYavHssGxdMGsVEi/1mSkUnkfmCuWZY61QLR21o7+dI2d3k9e6
	 DeGscSEuhsKDebTVXj28XBZCb7RCKnsHzep+YPaoC6mLpJyChRAN7pSIPVBAuUHc26K4H
	 N6QSpxdHIiF8OUr6emHFtHobw91PVDwxU7Bv3IBCz4LfNZdov5cR7QIMzncBv31fh9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA47606A32A
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 12:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA47606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3DrR_aPBqhCabAA--.22738S2;
	Sun, 08 Nov 2026 20:18:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: nv_tco: drop the PCI device reference on
 failure and teardown
Date: Sun, 08 Nov 2026 12:18:07 +0000
Message-ID: <20261108121811.3410001-1-vulab@iscas.ac.cn>
In-Reply-To: <43aef665-bdaf-45bb-9a60-a995ed1c6ba5@roeck-us.net>
References: <20261104021545.1468838-1-vulab@iscas.ac.cn>
 <20261104-gregarious-carmine-fennec-9ceefc@quoll>
 <43aef665-bdaf-45bb-9a60-a995ed1c6ba5@roeck-us.net>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAB3DrR_aPBqhCabAA--.22738S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWkJrWxtr4ktw1UZw1rCrg_yoW8Wr4rpF
	Z8KFWUtFZrKFyIv3y7Aw48Xa4FyrW5Ka48KrZ5GrWrG345Cry3u3s2gF1qvasxWr4rJay2
	vrW7urykWa1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48
	ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07bbL05UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgFA2rv42DRDgAAsQ

Hi Guenter,

Sorry for the late reply, and for the confusion this resend caused. The
extra work it put on you and Wim is my fault.

You are right that this is a resend. I posted the same fix on 16 September
as "watchdog: nv_tco: Fix pci_dev reference leak in nv_tco_getdevice()"
(20260916170240.2086046-1-vulab@iscas.ac.cn). That thread only ever got a
reply from sashiko-bot, so after a few weeks I queued the patch again as a
new submission instead of sending a proper v2 with a changelog and a link
to the old thread. That was the wrong thing to do, and it is what makes
the two submissions look unrelated. Both are from this one name and
address; if you have a submission by another name in mind, please point me
at the message-id and I will look into it.

I accept the technical point as well. nv_tco does not use the watchdog
core, it is a 15+ year old driver that has not been functionally modified
for a long time, and I have no report of the leak from a real system.
Under your rule that such drivers need real-world evidence, the patch
should not go in. Please treat it as withdrawn; I will not resend it. I
should not have added Cc: stable to it either.

Krzysztof was also right about checkpatch: the Assisted-by line in the
patch is reported as an unrecognized address, which I should have seen
before posting, and it is not a documented tag anyway.

For transparency: the candidate came from our static analysis tooling, and
DeepSeek and GPT-6.1 Sol were used to audit it and to help write the fix; it
was found by inspection only and was not tested on hardware.

Sorry again for the noise.

Wentao

