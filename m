Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795172495;
	b=g721F74B13uY/QBAVHemqRjdzy1/GUwK1jIkGSW4yYllsUiVD/SxHYW7Yy3XULtvmqjq
	 RUe3cQxy+hTupaWpc3uGySW4UcfcMUOUpDWmLjHkFg1oGqYERkQmHF0RgMSqSGxV+dW2X
	 ONs8xjrFqsA96jFKTHAFIVjwopjEVj/7U1WveUwrThLkMpz/l/QGdazZzxoj0t89qogKW
	 dNkZOl5f0ycUhFYjYkLZTSmWctd2BYS87xMBO55FKdmPvJN54xCg1On/xNtB85JSCNbDH
	 nU0wg7lqC/8NDpwyx+py6KndMJA4T0IzuEF5q6tH1nShBka2WsaC4py2I4BjmmtTYBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qRhTbOFQ8qqwBALU8BhSOIO7l1WfGteCJAegsd7jcOM=;
	b=MJ6MFMeG3nBlExGQ2jVLesFEfwvdumnDqkjBPo2boJXj87HbMe5kHy+r2l32XwkOMnWa
	 DEbEk6HmcyaTpHfq95W3+jobWuJzOOzOJHh4TtPaS2lcvc9C91QoCVwA+aktdEtlmY023
	 shZED6kO+0UTNa1CAFoh/ajbWshf/F4sPBLYU08BsHRwEokdX6I6J/N896z6HDlM5Yu8f
	 ioRUI4Am+h51oB0QDpj5HN33UE6YVgN4HSAaPnblC42mMfB6KG8rRpxUv15wCD+Y4wdru
	 +4tW35dLW1GCXo0BcnS5XZe2hfD86sXapweJ1sfoypzJ9+Sxox7cEo51S4JjvjJFUVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=me4MaoJu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC737606A337
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 11:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC737606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=me4MaoJu
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae85add512so2881721fa.0
        for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 03:01:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795172493; cv=none;
        d=google.com; s=arc-20260327;
        b=ABxbeTcGqzlEFRsptlI0dEcOH6yCXJz7d4gNOVRNbbLtdum+BQ7Zve17EhYH5wzRkk
         6TTklo6irdrK2DSZQkKt6sB6L6VNe2IhzncOZR6rsfhiq96P6zR0T8/ECXKJ9C5wBXjf
         0PE4toWIr5Qd2o9jnDbNxEhKHPSRWkeMY75CffT2Tp/2vmJXzeNiTdJdklZuuGI0lLSZ
         N8+QAPk0Dr2ru3daz/VSrGVMCtkNpx44rcYCqOtm+HYBouXu8Ek3ca8weJ5sufwyQAQ5
         YMuza61PfIxXJ0ay6qM3hdmN2Kk4nDSR5Y01WqyEbo3APcby0xmVx6FGextL0g8Mq+0G
         s0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRhTbOFQ8qqwBALU8BhSOIO7l1WfGteCJAegsd7jcOM=;
        fh=WsNhasX+RB4oLZaLQNDwmGZCWnuBU6WwL43Tmi6HPKY=;
        b=NN/fwijTawiD+Kpyqp8TxlmX2X1gHTiLuO6aTrf9rvGV7qdyT9RDbVxAyCKobzO+ZS
         l+zxm+RON2Eeh4jQ6D4oIcZ9Gf/0PkMjHPd1+iXh9HqoXynfyOqPFOnJF58W8EMshefY
         +muzzceQ6xyltwNBKDVkZlQgJ6aOGVVpmmuGjl+xeLbNecIPqgDZboGY23YY05AZ0Dyb
         Yv38mudAjDbHIGu4o3SXL2uHfxq1w0GTMbQEVQuBkNgvTfBO0DSKqJV7jUvIzzPU9m/U
         Idj4H7hri7DR/1li+X7RXHcVpyuYOvyW6YQ9voTn04b4GZ+z+iW0VuLVXqiGacaOOyWs
         2anw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1795172493; x=1795777293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRhTbOFQ8qqwBALU8BhSOIO7l1WfGteCJAegsd7jcOM=;
        b=me4MaoJuh+qK7iYJvWJ7R3lMYiumDv7BoQTmZKyePPQtvlIDkN8bSxHWBehSpponLK
         snb+ICkSX14Yf0ZULyq/We+FtLdf5t78D4H1GFvbPcIiRae2cQ096koGFu+6wjSZ/t/q
         FURT56w8xLKhkNIlLAoZxVtvY/U/hwuGK2f919rXgltvRXlX3iJDi97cHHK3geNRgzRL
         gxzy4yZPVgftYA9M8j3B5/p7iLv37hMAwlHknHoJNTmBHd2Bwjq93MDlmsXpMbXqOqmN
         9xZaPtFd8b19KgZoq4h/s2w4Zc16zS5FpYfmH5lwex3UB87PAN86dBz37c0PPTDwVOS7
         Uiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172493; x=1795777293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRhTbOFQ8qqwBALU8BhSOIO7l1WfGteCJAegsd7jcOM=;
        b=0ydifvl8XAc9T47JQRzOHHMsWBh6DeNbO8/uwYE5MRpYjL/ezG/hNrxlmIHePZlX2B
         kFDOyd0X7sHQpmbXcwSvy1Djt8uzNk0mnLP3gUbcGfloogNLfpr+ggqcY+siqMkZXbYB
         PCY23C24VKRj0cTd3YKvRRBt6ZQP8EO/LY7zrX0vdrxxory0b+5mJZn36C5eyqq7RuvL
         6gC1iK/ujTPfWn/ro5u0MYToTiyv64s44bckCdx1G6Ar3FKkB/9ArTCsVCnmLke2RtSt
         /0dG1LVh92lt7J73F2P9T4OwFrp9WzJ4/KgmzMTg8WK+kOZQ+2TEEp2f6zPJ2yoaQufS
         MJFw==
X-Forwarded-Encrypted: i=1; AL+hErHo4NtWnFXusUrB08EH7cFBngNCCVQ7XrEc77ae8KU7rDO84ljndp5/1PkwS47rbYBrSmjHgmMHFXPDDiPZfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QccnRnSSLmP17r0CUEf4ruua9WmNnLj1ye0Yq1kaDLNLE52ez
	1kUCZeVkmMouuYHJNnFp9CuN+QtUxWBDO/vcavG2PtZINFp1Db7vQrxIY/TaxhzULuV5DLQtp4G
	CSZFVTydAsIdRLVaIg6TLhdF2wK7bk7QmZ5hHnfDdAg==
X-Gm-Gg: AZFdTZcjPDhWFm6VK0PoqUn0oxOCK5hCxKExfvbWSUwev7N/6CmcjzIcM7McxTPUwSr
	dLumwg/unli4BDROGywnxtuRWqESWc/wAFQ9mTNnAgIMm7NkG4+6jBI/Dq9u2q2PPztFqHLHWAp
	nLfD8lBSe8sP7fV9xBTIpFQunelYMZanuMEFrRqkCTXGjhUyPMypmHUrCjjpqmgFj/XV9ThFipA
	0Qdqx01014ymWem7qzswbIF0OQQrI2orxHpKEysGI4ON7uXpn/PM3xe1hyLvnHquE2RRoidK/0f
	L50xyhmBBOYwn8EfFN9OpKPIPmkRMrlr/7Nfz0Ko69IVXKMRy4+Y0RJJpNylf3N6RWLiiUmEWk6
	yMFQ6iEjNHuoLbLMlfRh7ouLLtGJvIps3vQK7j7ddZekFSQeX86hu2OQuqcaPjeT+ImdScfWU6E
	2si0rpS3SCPlDzke2c0xWNsDAA9QfCxdzTJfaRiT+e46Ozkx/zSd5y
X-Received: by 2002:a05:6512:1048:b0:5b8:bc5e:d10e with SMTP id
 2adb3069b0e04-5c1bc81c3c4mr802688e87.56.1795172492078; Fri, 20 Nov 2026
 03:01:32 -0800 (PST)
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
 <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com> <CAAhSdy2ZKBc8A522viUWZbn418MC-C2cy7pQYLBFYn4gsTvJ8Q@mail.gmail.com>
 <10c7622c-4dc4-4ffd-89b1-0678e3553f53@roeck-us.net>
In-Reply-To: <10c7622c-4dc4-4ffd-89b1-0678e3553f53@roeck-us.net>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 20 Nov 2026 16:31:20 +0530
X-Gm-Features: Aa3M54os6gtfofDw9EYiE_SoRvn75n9bUS0KZHJkEbw23kks-0yxXNMYX9KJ-rw
Message-ID: <CAAhSdy0vhaWV0kFRJhPJJoLezadJHNGfKsM-k2w_4io_vpANaw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Prajwal N <prajwal.n@oss.qualcomm.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, wim@linux-watchdog.org, 
	radim.krcmar@oss.qualcomm.com, anup.patel@oss.qualcomm.com, 
	linux-riscv@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	prajwal.n.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 8:57=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 11/19/26 07:04, Anup Patel wrote:
> > On Wed, Nov 18, 2026 at 2:52=E2=80=AFPM Prajwal N <prajwal.n@oss.qualco=
mm.com> wrote:
> >>
> >> Add the RISCV_SBI_WATCHDOG Kconfig option, which depends on
> >> RISCV and RISCV_SBI support.
> >
> > Kconfig option is always needed when adding new driver so
> > there is not much value in having this statement in commit
> > description.
> >
> >>
> >> Add a watchdog driver for the RISC-V SBI watchdog extension.
> >> The driver integrates with the Linux watchdog framework to
> >> configure and control the watchdog. The driver invokes the
> >> SBI watchdog using the standard SBI calls.
> >>
> >> Support pretimeout event notifications using Message Signaled
> >> Interrupts (MSIs).
> >>
> >> Signed-off-by: Prajwal N <prajwal.n@oss.qualcomm.com>
> >> ---
> >>   drivers/watchdog/Kconfig         |  10 +
> >>   drivers/watchdog/Makefile        |   1 +
> >>   drivers/watchdog/riscv_sbi_wdt.c | 436 +++++++++++++++++++++++++++++=
++
> >>   3 files changed, 447 insertions(+)
> >>   create mode 100644 drivers/watchdog/riscv_sbi_wdt.c
> >>
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index f7d0a0c2c0ef..d6b4e8ccd057 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -2164,6 +2164,16 @@ config STARFIVE_WATCHDOG
> >>            Say Y here to support the watchdog of StarFive JH7100 and J=
H7110
> >>            SoC. This driver can also be built as a module if choose M.
> >>
> >> +config RISCV_SBI_WATCHDOG
> >> +       tristate "RISC-V SBI based Watchdog support"
> >> +       depends on RISCV_SBI
> >> +       default RISCV
> >> +       select WATCHDOG_CORE
> >
> > Drop "select WATCHDOG_CORE" instead extend "depends on"
> > to include WATCHDOG_CORE (just like other watchdog drivers).
> >
>
> Please explain what you are talking about here.
> Literally every watchdog driver uses "select WATCHDOG_CORE".
>

Please ignore this comment. I got confused by various
WATCHDOG_PRETIMEOUT_xyz kconfig options.

Regards,
Anup
