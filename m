Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96F390211
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654354; cv=none; b=hucZA3Fu+PSeVE5q0vv2dVE0v65HqN11w96154I5tmwOdhnrEdpyrbsu9oQxcqrZ+IFLULcJsXXoyXDEp5JJohg3vBg340y+q/xRB5FnXkFDP03d19mOoaVBx2ejRZLj1HKZ5nVLERAz76aPEVK+7nrAml3i3jpfM8tvAYXUTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654354; c=relaxed/simple;
	bh=esqrcU2iBVY8ci/hzt1UovcnezFcilbxILgA7vFytvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VANHyF+CRUnhwcRDFVLd8CJ9jaoHTB8/kUBenk7H0SpCU2AbEr61MU8rCgIvGn3e84TLQMq4FLY0WIKHhDQrN8N6YorB42eJyOeGTuWJvVyAx6koLaXdV50CSL5CDlv0K/AoN1wV1T+gftdLPRt3c4f4GDaAmAq+T5KirUIfvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNm9uV8w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Koa7Ox7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNm9uV8w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Koa7Ox7T"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G65TEK1068696
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=; b=jNm9uV8wa7esxl23
	r9DP5HoqaYHcDUIqlxJHYWwY1Fp3Jy6Wi0qaxhB/TZ1RCg/NH1fXtASxjZs8D0rG
	NvE6y938E9UPgqduAJ7tocNKi3+OTDm/wE+wYT6ywH5m9dgZ3srcq3I8+d64pzvU
	svwgMKlCJKEEiOJ7MxFht8CYa2STD7z2OmO1EW/RXaLq6hyxZp62tTeX8xWs1A/H
	95qD7oyG1nHjMJv+CVZmUVNW9yrEC2WGIQdE5WcX7Qze5CIaHqokyJernc4tNBmo
	w7DEh0EurOSrrjn7+E4qw8gA2PAUb1rO5HM5GEfcgqjbsTgVxYLdyeYjTXVn0VAu
	IiL0yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027d4h5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81be6f05so2754716785a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654351; x=1774259151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=;
        b=Koa7Ox7TwZSlaIOYMAy4dR9Jw6DESTj45d6sBtCCM9o6cs8QLC4ijrBFsu1CyU+KnB
         Vgz3eiW2JrXqs/Kqi8JpX4Htwh9LCYj8gIPkU9Iy8b+9DwlXpjBpNAJPmDAJwI/bQYMZ
         FZtZ3ETiHFzM6/V7aASNcw24X54c8izsAGzdb08OvgIOa+cHBlLkUKVzn2ut023kwcM4
         CRdjHzPGP0//4JfqR5uI3kBHZ/4OBwwbDB4EcsojzMA92H4t9oZCoD3ErGL82pAyag8y
         u9M7R+WRb2970VphAwN7m4vDWJYcpJURyxx81BshwibVMDiyOi1h9zkZv8DsNgxP5XY9
         kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654351; x=1774259151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=;
        b=qAzaNxqnga1uYOn4GD6syKyhoCb33fD2bOYwvqzndmxMJsScxT9cUR1VUmlzvPyRNA
         3DUbcsnlLM3z5PaeRbnA/nj0rR3snUOHux0WYy1PIrtKf1YYwMN9nt0862KDKiv6yjGS
         XM5LHVv5LG7zQJfRkJsDwXo42d242qT92BoqqD040NsZEJu8kvfr2I9fg5jR7uEkeJtv
         BV59+JlAo2ygwYH+Da7RkOx+qX2jE6D8VADMDUDmrzOzwjEatVA2LzRgKHTdBJ2IGOyW
         Sf63frfpyW9J5d8DAFwKUb61/ciPVHn9EtK1KZOsrok9n8xzaq3XYtsfc/367zqtoptq
         z1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUkIawtZPSdz0VFX1cu5hNUDS4/OwpHU35JAOiVo5e4ewklwqlnbMIZZhKKXQvZh3LSn4juaNx4dSN1nu3Nqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3b1ZvcSoo6C7p/Lav6jKTQzW+N8VkbT3XHknj8Ob4sPEDT40F
	AkddM5RYygq6g9A8dXoVaxJJ4Ff4Ar4Od/VCwb5Qd4y+PvcCRy4R6Ys08GAF0RDQJzIN0ifCcXw
	iOQTr2dUO7q2RKi8KTKCh44rKFBuXuPX+97yeb2mWPx7RRBzPnm1XTHud9wm0Zl3dZ5n7gg==
X-Gm-Gg: ATEYQzyeUIHN8U9SZUwxCkgjFMwO6YivvXApfoSyXxmrNhKk7Z4POWWwaPiaadg29YP
	+4wxpiM9x0uTGospeZyZQcKt3prFjFglnI6lTdo2wVenAKN5EQjUzS3AeBxMBiT9K8olKKWBrmA
	hNkM19dMgnPB83qgB96yg+AdqDeuSR3Zcoz2/6ZzgNvTUaz7sReSSl9tt8cYbiDncZw42CZ+8DV
	OeyVVTXqAxUD4G8P5bKUjFt8dK9OhPC4bGeudJRfnb1YZD84R/QtWGuvJ7CSLa6rANn9Umhg5Vk
	hAGbwrpCjG1umhRiP8M2XS5AGBb34I0jeA1rXBoQeJylPwYh2NhT0LupqgKgPYL3OrlYSz8oyeH
	cigTRzYgdkYwmXqLDa2I3xM2ZMoPolTeIoeDPPXiwR4Kv0VYaMTO3
X-Received: by 2002:a05:620a:4153:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-8cdb5b2598emr1635909885a.53.1773654351008;
        Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-8cdb5b2598emr1635907985a.53.1773654350529;
        Mon, 16 Mar 2026 02:45:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:24 +0100
Subject: [PATCH v2 4/9] leds: Kconfig: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-4-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=808;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=esqrcU2iBVY8ci/hzt1UovcnezFcilbxILgA7vFytvo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E8i6aEL4piTNPBuxvNyhkggWe1e3NVYraN7
 Ks7jiQgHs+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPAAKCRAFnS7L/zaE
 w/ZAD/9owgYgilZp+MsY55UDQRktGsR/H7gu25ynf1yhU4AxMzntmbgKtI8ceNacGdL80sij1rd
 BC1afcEdcSeocPHYhV8XrTHz09iBj+gnuOx806Aztjp7T2dAIN+2iEIjUM3kaBCEgSnqgV4zQr6
 KP800070rOt+5F9egqM0Lv6yiQUDNMAn8zKj1lHgWzcRAX+/m+tJCaOTvMQ+lfYmN8RwfNOnafG
 cDonwS9X74nEm1gLh3vwBangOT0m6NA/CaV9RZH8/DXyYqAIvvCpV8Jz3U2D1pRdGxSrHe9eRup
 cbjzFzq/LgbVkxDXxoTu4i4o1iNuhn4k1/feicc2rZzuUySztakWwWWSm5acHzKR6Ptz1WMQI89
 Hai2+hXihj3LpxTO/VnuyrqwkfChDWqcIYxw3Vsn9nZdRi4NraVQGY/AjuFi4NDRw8E0I0oIZ0V
 bqrdOjurKqeApM8B3x+pdjk3MGTlDbhn/AQrLzGeiWpOHr5yNZeuN+E8BiBQFvka6LJRALRFKtN
 lpy5tTKnZuANqh+kbu8XfvN1aim+wXkG0r+mrAX66Sm6PuUCfDKrXHz5NKSMBkBfTvAtGmGzu0s
 L0qw3k6k3RvIxBjnOdCxgcNf83bKNrudGRNJ53TXD5F7++vEy53ZASRmatk5lcOn2fdcam0C7NF
 v/S76FvWP49WAfg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: nVinqLPKSDcqbpE04k9cCjSNTAC8wT8p
X-Proofpoint-ORIG-GUID: nVinqLPKSDcqbpE04k9cCjSNTAC8wT8p
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7d14f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ULgK7OEL32dECu8VbM0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX+fGVJGVCccl+
 xR7S+JPycM3IgHdMHRrnUmPEcCF7aZ1yzt3UvBzfJNoBV3s8sh4vRZnEPvRuTr7/xV98/DFJFQJ
 L52qISpUA7A7KjaV914+GdqYb3sTTPsfmilO+WnooiIMgSjExEnKjfAHCJA+V2u3i5AXJY9jqwA
 L/XV2Qnb6rFiN3Az7pSYAF8IhX+g2S8LNxmSQeRSTuB3uA6FrkKmvEwKsQSFvDw4f/Evvf0K7rm
 JuHvt2REz8v3K04tImzQIGdTZjNXqnMhcgkTumKTvmLJViegUB9tcgIj2DL0S5XQ9ZWQMhfBA6m
 2xT4hr6PR3h7TrCtONGHSdK2p4j0FXxOrmDmEKmGcqxj5zmBH0Q1qWa2/GK1d1MZpeW57AfEnbW
 UkuIgl3yp+lR7jXh7zquHvWWj48dpX5LapZzUPHXzwlC96XmFcmg8j2ccw+qXzpMDqQnRpHQMqm
 +HRRP0vm0w5cn95GYKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/leds/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 597d7a79c988b35f304e953e873af3afe2ae04b8..f4a0a3c8c8705e0f10ba26584277dbb2d5eac5b5 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -765,7 +765,6 @@ config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
 	depends on LEDS_CLASS
 	depends on MACH_KIRKWOOD || COMPILE_TEST
-	depends on OF_GPIO
 	default MACH_KIRKWOOD
 	help
 	  This option enables support for LEDs found on the LaCie 2Big

-- 
2.47.3

