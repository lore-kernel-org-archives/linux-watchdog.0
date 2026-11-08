Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140298;
	b=b3Hq9yilVrNe1T/joR41qRWoZO7bxVlhQ+bQMglgDrcKIZhXEPt19nv80c8WqTEYe6V6
	 ETc57KTVwiZS2E4oz9gI19pGhJ2CZDr/foseN9SatEpDCsXJgFGgfIRK9J4XzMkyTiyqm
	 1bVZbjxw26YDwv7HKXtEBWNovNMH5b6/Pu2Tizx8mnuw1DjvU18Hk90+oO2XEf0tmxf95
	 6YHjqtTmz1fED070y5GCSA9B3UAVPznoJE0eSwWgIQ14Y5GTvFvK30yh+N6YkPYdA/OJo
	 MsjpqxWxXzxMc5ozZ62wltOkkx/VqHi1EKmK4b5+aC7o6OA1IqwbAMhX8RsB4xu1kfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140298;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=AHMv9274CDbqYftJy2yBT59+TYLTbgqxJVfrvpKN+i8=;
	b=myfidBVm0WTfIqQA0r6PAfGEBpARXgOBgnHaNwcw8EpuvDXFeTUkKTBqoC4GRdSZ3DDx
	 MumcoPKbg7g3/pB7UyHOk2KeQoLTnui07p5qPGEUpQp8kuJWq1tmwZGakxbAwqhJCbbb5
	 ZJrWi/LbfW3Y8IEuYsRVehNuiGRiuVHY/v2rk2hun+TE7vjYrlGVIKNh7m42YO7IJIM62
	 4sCFBoqjQtNKzTL1wdM7qKv/9J0TuQgGH4OUtiaU5fo7hBjJ35iQuKzTuOnKsU3MCksJH
	 R6vPgxVgYrkv2O2cczFDLvO0gGwVJTKUqA+m5IHhnF3blYJ7w7ZohdxgFivUnRWTDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E7606A326
	for <linux-watchdog@vger.kernel.org>; Sun,  8 Nov 2026 12:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3zrODaPBqtiabAA--.33423S2;
	Sun, 08 Nov 2026 20:18:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Ziv Xu <ziv.xu@starfivetech.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: starfive-wdt: drop the runtime PM reference
 when start fails
Date: Sun, 08 Nov 2026 12:18:07 +0000
Message-ID: <20261108121811.3410002-1-vulab@iscas.ac.cn>
In-Reply-To: <33e354db-b4f0-4f96-afcd-4912fb296ad1@roeck-us.net>
References: <20261104021527.1468703-1-vulab@iscas.ac.cn>
 <20261104-aggressive-poised-lorikeet-a5cc5c@quoll>
 <33e354db-b4f0-4f96-afcd-4912fb296ad1@roeck-us.net>
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
X-CM-TRANSID:zQCowAA3zrODaPBqtiabAA--.33423S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKr47Kw13uw45tFWrZrWxtFb_yoW8JF1fp3
	9xKrs5trs7Jan7Aw4DZa17Za4rZ393K398tFyvgay093WYgF17tw1Syryj9ry7Zr95W3ZF
	vF4Fv3sxCF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	b818PUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgAFA2rv4zLRFAAAsR

Hi Guenter,

Sorry for the late reply, and for adding to the pile of patches on this
driver. The extra work that created for you is on me.

I agree with the limited embargo. I will not send any further patch for
starfive-wdt unless it carries a Reviewed-by or Acked-by from Xingyu or
Ziv, and I have nothing else queued for this driver.

My patch can simply be dropped. [PATCH v2 1/8] covers the same path: if
starfive_wdt_start() fails after a successful resume, the runtime PM
reference is now put before returning, so nothing is lost by dropping
mine.

For the record, in case it helps you work out the state of the driver:
the November patch was not a resubmission of the September one you
applied. The September fix replaced pm_runtime_get_sync() with
pm_runtime_resume_and_get() and so handles a failed resume; it left the
case where the resume succeeds and starfive_wdt_start() then fails, which
is what the November patch addressed. Both were mine, from this one name
and address.

For transparency: the candidate came from our static analysis tooling, and
DeepSeek and GPT-6.1 Sol were used to audit it and to help write the fix; it
was found by inspection only and was not tested on hardware.

Thanks for sorting the driver out, and sorry for the noise.

Wentao

