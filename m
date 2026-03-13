Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAB38F638
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409456; cv=none; b=ovDd4eA8oh31tHLJ61QCtyoBUONJ5X+FputRnUk1p5U+3KekJdv2QYe5+w5hAi2e6+HBU4ZIxgVeEbwOAJ3slaSJ4Nvtf+fynMwxPMozXnpaIlmro8chtz/NtZgYidxPM1nkbyvx2AmFPjm+jw9A3z098rmEozR6og314i1OJk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409456; c=relaxed/simple;
	bh=kPh4JRKsDotwPE2S/JesaTmap1N+yj7JN+2zbuQjdQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbNJHhEEqQOSVNQq9JQgKBpdtNsAeImN3PC+nDP21ynCarpZ4+49KRreXspYk8IEQeA7LisSoV7ACd9LpxD/wyJkpkmUFLThsauTB7S1pxY/j1qi8dgSMie4qYXlWWypXAJSqMBQGXXtRa/L+GrGVESoiaysYberUoyAZnOnwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KtbSMsLt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SObXtzdR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KtbSMsLt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SObXtzdR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC8DDK4140708
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 13:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=; b=KtbSMsLtNsll432M
	ZTzKQXe8T/DK/n7b9XjI6u2X8hEFxS6+vToHFGAIETMkOYmiyrVQx1Ron0HTNUGw
	L/7hqLNFcZtO+7ieK6wWqj/GrMcUMTkirbNDQOXKEyEzX++Y07x36vS4BckJkiBw
	i0e+TKFjJYkL6k4y12GD35M2kL8ToRgaS6v3aDis+sQW046oTfw6VRUKYvC55XyU
	GavC+gmfdoZZxfCSN9TNUX7z0/IKdGFuTV1BuxzhmfyaKB9OzNJ/1nmkV5iIg9BW
	H8cIWU+Z3DaF7xCU6hevUNHgxDD88Y9uGNl2srLPZ4lN68ffEs3Qj3IQtVVXyVOS
	oZVnQA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn29tbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 13:44:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd81506677so1290480385a.1
        for <linux-watchdog@vger.kernel.org>; Fri, 13 Mar 2026 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773409454; x=1774014254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=;
        b=SObXtzdRrSru9OolzC5msz8Pripq93dY0a0iM5lbQwBl+ye+xEBpdd4zQo+KyfwEDv
         IjVaqDl4PeUkPJvG9NwX5h06TTAtT63n6WvwVwhM3/ivwF63ScoL06ZURRW6dqXdKZw3
         5CqDqvwBW9+CYcgEb19Qe9Qujf2oeXMYF9I1H7eh5cHzc0gutftPuWgchOsDymzclPfV
         +5Lhm0zLaqsFJgg9Rqz21Pea1wWDDGoY6Jm6IuAHUBcIbIt+ne5itg+OeZYkFCYoKXdW
         pc/ZxLpoRUQaFJQZtj+pBhe1xWGmcUAJL9fwI3qJAf/EXjc6qcN05uNOVvpy/76y5nNd
         bn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409454; x=1774014254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoZHIkugLvxBFz6S6an3vh8XxLW2VljccTx776RcMfw=;
        b=mqoimcZFGaLYfwvcR5LTpcW6/aeHfa+ZskU4HddjBYftCaPinJCH8bE+R4D6reIonz
         6I5EZ6zhoLcaIPzOTTrPCu5JX/9oJeafVWo0YMK6R4M/JKjg9ENJDS9XREciV10WwWCm
         0MHg3kR8L5LfJp73E+aoFRx5wwH9W0B3Ry9v9WWPrVnpkFw0uPmi4C7AATyuuZMDI7Hb
         d/GclODvucoIDfBqA93Q+ItqlBm7vQtPCT8Kf04Jk0XkWpApZv9khaNrLE7NQvtU6XDz
         lxfNxspYi1ohtWeEohkVzHkiueCyL17yOlLX/MQxc2G5s6XIq7vrSUs6F/TmxhjC5Dww
         97gg==
X-Forwarded-Encrypted: i=1; AJvYcCXbOaspXppcB3VTc6KQ/LcMNGqzeLuIDfsxKTDPh9flIq0xgjCO9anyGnlUE7SYAL9TNij2QrjR9v5x4VNLZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnrxHob2K7AvcR3SGwqviSMfWaruBnUGo65anIoQUXhWhnVkh
	9WjMBFo6d2L7fo0DF0jCM2F8m0gZNynF8FvH3iS2gfsRyibp3Rr+NJFjUrwpJcvUmTcdj8R3TlE
	R7KyzfZ7fcjTbGIoWdHsbtK8xny/6tZBU+oGJK9FzbujmluWt1iRqn4LZICll3D1L6TVJeQ==
X-Gm-Gg: ATEYQzwvHU6e64svzDyxLs2jAjfFwai6Oztf++PqcGTfAMj6Lx2PdIT8xMr8quD0GhX
	T3BEW+SC9m0q0wpT+JQx4rEdBIw3aTrtpz/FXDt5+CX0K/9eWq27+Oy2r2kKQQWx6xzp+RIXM/g
	58DG5I1ySIeGWX43W9GhwEA+S7Bl9Hjr7lmHKAHYx9vSmFkdnFun7lLCxb0rkzp0mlOYLMd6IW2
	spAdL0axJfsSdcodd7syTpfIVZCSG0VUg1eHT54ZIeN86juFSVdFt1Sp9ZnMyKOUuFx6jwdtTsc
	/RKlgFxJ1Mx4WKvJSE03AR79jSpO5QzG3zDvhrKrjA8bBKEWFa84fTdKKJOQqlzk8qUQe2U9ehM
	VrUuwiGvct0WasqIxfK7pkxRVFQAcOACNZXYpeJi603/a2g0qUuU=
X-Received: by 2002:a05:620a:4623:b0:8cd:8fb7:7aed with SMTP id af79cd13be357-8cdb5b5fb55mr457720185a.49.1773409453963;
        Fri, 13 Mar 2026 06:44:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:8cd:8fb7:7aed with SMTP id af79cd13be357-8cdb5b5fb55mr457712985a.49.1773409453455;
        Fri, 13 Mar 2026 06:44:13 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:f055:6536:e7d6:661c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm17696873f8f.18.2026.03.13.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:44:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 00/14] gpio: remove uneeded Kconfig dependencies on OF_GPIO
Date: Fri, 13 Mar 2026 14:43:53 +0100
Message-ID: <177340937994.51547.9424773605486301589.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YEnplDygG5MS7c3VFDgyowzOh9ywjICR
X-Proofpoint-GUID: YEnplDygG5MS7c3VFDgyowzOh9ywjICR
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b414ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5BVL746LnNak5i1nQvMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEwOSBTYWx0ZWRfXwdmc2owqmkBW
 HCCUcWVdwxVnHVvIIDMHqPkJKZolwy7QXkXXr+Eyp2Ba1xcaKw4Xf6ZrKBhWXhbsfm0++9wVcCJ
 Hmas6UkuwglvHck+6vUvPFT+F+436kox8nyOt6fcqEuhqFL+mEH+RGQ0LyWR2FiA6JkgTeXCiH8
 nKNv6my0aUn6l4DnW4XfN/4Q/hT4Rerr0z93Flswil+zeBVO04OwSO2SEm8AxhSlfuNGM6KCvm+
 a0cwhaQmIuc2efD44x5YmX+FB6P+pMSIYhW35a0MAat3wW7tfAoQSWthKz58z0776FsORDiaETw
 yfoIPn6VrkqUvjwopLZC864fni6M1ZpCAIuPY6QVbcdVDjcoVocV8us5Zu4c9RO3HCxjcPXaRO6
 BMYZP90zmvRuP+Qjc730Q1J+iIaCjHuVL+GVCyHOWYG7Bsx21lTo+we9Y/680s4/Blf1OG/AFQQ
 HjDlIW11jD70LJoBxAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130109


On Wed, 04 Mar 2026 10:02:21 +0100, Bartosz Golaszewski wrote:
> NOTE: Each patch in this series can be picked up independently into
> maintainer trees.
> 
> CONFIG_OF_GPIO is a switch that enables the compilation of the gpiolib-of
> module. The module itself handles GPIO lookup via the OF-node tree and
> is automatically enabled on all OF systems. It does not export any
> public symbols to drivers. There is no reason for them to select or
> depend on it in Kconfig.
> 
> [...]

I'm picking up the ones that were acked and will send a smaller series
addressing the issue pointed out by Guenter.

[02/14] arc: axs10x: drop unneeded dependency on OF_GPIO
        https://git.kernel.org/brgl/c/d2cd20f7c2a4e4bf4fca844c01e925b112c5a2c5
[03/14] powerpc: drop unneeded dependency on OF_GPIO
        https://git.kernel.org/brgl/c/dd1cdfb20e44e295512080dea508771b6a1f1c0a
[05/14] regulator: drop unneeded dependencies on OF_GPIO
        https://git.kernel.org/brgl/c/bf017304fce10933f18fafe140bf749fb9672058

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
