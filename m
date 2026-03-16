Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C248372EE1
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654344; cv=none; b=rGstMVTP+zQvaZCp92nIubqZwoFAfZ0YI7bN3asZFXebfCTZbtEb5b3cKMtqgiBdLnYJMHlcU5WmdG4/PXU+s2r6qqOVaaH/T70bt6HO/nteQBc1vbeQ3LVnnFWcDc7qBEURVx+I+aKqQrc+Sob2vRsRbr2bfLSX2uDmP6t4Y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654344; c=relaxed/simple;
	bh=wNifxD/uVuc7NAbXzSxDhaJ7op2FNUcGF/+rEs7q8XY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GZYDD75qtE5cZUBJDMiPBZqCLzDCgCMPpg9OEhTET84ivFmAGfH3+Xy9G6kT7rS2k/Z34ZueD7ksU+9GqjchnRR0MzBZ6bYdFzfn8SmViLIyubavF8IVPKzlZlypm0YNxBtdzFnJ9MNITogVgwYANa/UjFuuN76Tn9fsqJdZHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkIpYnIB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ae/QgGRU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkIpYnIB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ae/QgGRU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64qVL1724895
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eZX3+pV1mLh4qQV/ja7HXP
	0WPf1mmp2fnKR9a3HpTPE=; b=RkIpYnIBHca+sMT16Qy0AUvaVdmiMC/ZMaDeJw
	nudeVmDv68Z0PU1UJ1zceSKj5smRxTI/jOGS1e/JGesQ5HKc5B0m2kkd4cxtPsve
	qPylS5qhdkk7yzcgXLQ6XyDTDDwltTQ3yyNCCtB1zdjB84kBCB6yFULjlxlw/K4Z
	4uomx0/Idy6zBMQvuMh78Ucy1YqKsgfJSe4nV27j1XN0gzLlUmRx4J4KaWvWRQmE
	LiqZ2snYGLS2bpapFcpzTud9dxsxAvAmmsbDj5kbE6LrCDrLWNWCNaTjsTwcnCNK
	r6PWGbLNsdyqN7RlCw9rszhOJlHIKzOTSjAZdxEpwweJFa2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0udn01w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7d66afceso3148238285a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654342; x=1774259142; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZX3+pV1mLh4qQV/ja7HXP0WPf1mmp2fnKR9a3HpTPE=;
        b=Ae/QgGRU5CTzgyyqoEWpShJ/xGZX5zCSN0RSgfLn+vVLCN3FczDGrs0/JYdWhQV2lt
         yG+CIwVI2jTq1bh7St+OWknF7nN6LM7OstyZT0m8L2DB9qT+uYajfcylk/9lkxgoqOc6
         34iMVnO1qEqZ7o8hEeUNn1/Pcnq6m+5ChlQwthulFlGCtFzTpEelAYUdmItu0OEGO0cE
         HO/hEP9ZxkCzsDdjx/nXrQqoQJVgmdj/ebZPEogCSh6iFFiyvqKWyeeHHWYLewda7EWv
         JYpg+7WTBnI0AMChNlBYM4Wr3h5y6wv5okT7FaOfyk0d9df8za5y6J//pDCq8zhCf62l
         eK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654342; x=1774259142;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZX3+pV1mLh4qQV/ja7HXP0WPf1mmp2fnKR9a3HpTPE=;
        b=AUfNGVxibhKhKd/rJq24ABC7tPEOAH8aIKwr3GyAv+tv3fbhpajc3pPs5RUSyAp/wJ
         82D9CO7mWbVZqmMdvGlK/CGapm4M1F/kWxGsIg8Tt/lmiy1a3UhBBw9HERP8Dd9nK/6C
         rDix2cqBTlqJS1XaWbT+0F5wi+/MvzMuiOXquih8vUBGABY+3IWNQgCoMBe+4xtKLoXm
         wE1Se/QZgsM54+UYiP0hoFB5UmoxYdQZnR0tndNjrMBzxoT8lKBsx+Sr70L1bV+vfNsL
         Y/8jkOE7S1uv7b3odR1krujtqdDP86nqJjROhuI+wnAJYRjPUrnjTyU8tkbKvnwA4I6W
         cfOw==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZoyZDFchi1RWmEVJoCindQgnvJua2hSLwCpdJm1iQrSUTkFCJZiOz0r6ql0BuTvXG8U/AS1EEb7ni2dFaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTkikcgrD92YCzXVPGS3wE1xTMF0DWdHIdV2WDubnb8AKvyIN
	Z03AHYjWx9BCs1IonwtoRom1abUQHp2YNHjubjGXGFn1QgfUJDcpdllX/hFmO1QU6CjabxKN5cz
	R0K2fEtnCKWFiYrzQwQEw7GAzbAiDmEJMLlqVkquNmPeEAKYAqBG0D/Jwd4ClRcrTITk69w==
X-Gm-Gg: ATEYQzy3UanBbeSIjJboD3GZ5h4FNjuTccJzHbTakjcLHS5UstwibyVpVWY7iDT0wED
	5TUwyX5uWzSoSm13Go0CKTS40HbVyhPNOuvppmHzd2lvOESA1R0hwDCQU71dvGLv/w59T+9LuTa
	9IaEYwlnnbdfmz3w9NSK5vUkZHHf2uCUNBzECOmNnCnCU7sNZmv9Ll+Bhxnpmth2zOBaV4s95s+
	bNjATZHWfuhNhpOFtCcuT/kivAffaXyx4RalX8HoxmQH0/8UOMqw/aIE4Y2w/QBiYP9z+XxOglX
	Ao5zSyNkcbzrzkw/RkBi/bByrh5dTuTvYWqo4iaiWS8py59MEEc04n/z+vkuVnUleCe0Z4/TSXX
	CMJM4skogwiyzsrdsur+/0QkqCRQvj1Fkgi7pbDauCb7B2KrDEsec
X-Received: by 2002:a05:620a:4483:b0:8cd:942e:82dc with SMTP id af79cd13be357-8cdb5b24ef6mr1646093585a.41.1773654341663;
        Mon, 16 Mar 2026 02:45:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:8cd:942e:82dc with SMTP id af79cd13be357-8cdb5b24ef6mr1646091385a.41.1773654341260;
        Mon, 16 Mar 2026 02:45:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/9] gpio: remove uneeded Kconfig dependencies on
 OF_GPIO
Date: Mon, 16 Mar 2026 10:45:20 +0100
Message-Id: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDRt2kC/3WNwQ6CMBBEf4Xs2SWlCk09+R+GQ1MW2Cgstko0p
 P9u5e5lkjfJvNkgUmCKcC42CLRyZJkz6EMBfnTzQMhdZtBKN+qoTjgsLCg93rzMPQ9IujbkjLd
 OWcirJVDP7914bTOPHJ8SPvvBWv3a/661QoVdbY2tGjKWzEViLB8vd/cyTWUOaFNKXyKp+Ia1A
 AAA
X-Change-ID: 20260304-gpio-of-kconfig-e257ea7c9a09
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2162;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wNifxD/uVuc7NAbXzSxDhaJ7op2FNUcGF/+rEs7q8XY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E0vDJ6dx7Ia4fQ84h8eE2etKlWvxV+vL3m+
 FEVG19udtmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRNAAKCRAFnS7L/zaE
 w6/JD/90RDo1/kiO8qCAJrcGU364A0L3DxLqgOQi4iAqM2tT6AZ4IE8R29waLnPi/L94XNMGssc
 6HxIsy7Y3Ohu7YbbfxiNadlDhwEg4QMApO1BXmGT7W6fGaMT2tujzIZ6P/trHTtxPCxSZPMbm9h
 B0Yk4F+ywcUCsz7Gfo2fflEKhwsAZwFbqUBajx7MdcfyVG06fLVTuOm0YcrxNs8H3zLk8TrRRLj
 y2vRZG/XYSoDtRBSaaaD2C/CEOPsRUnoKlqTIfgGwvhEmmek16YWzK+KI+sh5IRsDtq3H1lckrL
 kkVeGYBIf26BclCEVCYN9DImO9zVCx87bHDlap000sJ+jKQ6B7dNX2rzdnyXjOVP09M2LNo54nV
 B4mpWGWorOKR/74PzhcrIJW8U4jBDOtpXy3wN/CcOvAmIw8gkOXa6SKZRmqQ4LkNyfX3gvtPaR4
 XMzn8xIsNQfoXqRA4MMgKnuKvlTUwohMokVN7fSuEouA0y32kxCZf0/HKcLxr3pYphztnqNr63k
 iRLkyCoSuqmuPq+wBr9QhvOnwt9s5ralyNijLmHZcfnl0BJcKjESTvYqKk2onuu5C+5BFSun/M/
 A668YboqoN3Qf3s/yg1NIYO6jISfe+v7bKqUiWThxSvIU/hoSR11H/omw20ui5GzM72/Mv8Y8Tv
 BB/HL11BpfULi5g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=BJ2+bVQG c=1 sm=1 tr=0 ts=69b7d146 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=RbMT-lXscSRh0E1VkaUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: gkrLM4aHi8HsaC6y6Mu8kTLZzvD5RrcZ
X-Proofpoint-ORIG-GUID: gkrLM4aHi8HsaC6y6Mu8kTLZzvD5RrcZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX5FEgK0STGgK2
 EnF2rMWsu0UW2VERqUK8z59FvtXEdVApnQuc0E6nEZYXEdog1DTZT9/Uc9MCBg0nZX+aXVQ7U8g
 uz5nsTShFGCRUUXCgwJMFDFvFO5/Sh2IeX626zGtdz5epV1Q6nOWWZWtFDiDNvuio5+utSfGFVY
 DlShf7mQtnuh98LO/p0WuwvggFgL8paZwAJMdX/SVo5Tx8XJAk61ubxnoGlfwL8rgvlBFfFWmZV
 nCCE5YXa4ZYn97Q6OgYjJhNDH/M5Zd1uRc26YOaMQLK1chNiuiBrAnfQGE2a3c39PkKXvxTlISa
 kcM8CMDGpGOwfmCLnazosGAiK9OSor1mi5ah+XvKkDxKf4wDIgnLn91M1kL5YfUDlU8COXP876Z
 TObcJvK1nD8dFhYTQv78VXO9hxfEyMU5/A158fwwXgrI5mDjMFqKRxtFsjCeAnjuhpOjG9k9qz4
 DrRMBKrSx3m92xOKgmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

NOTE: Each patch in this series can be picked up independently into
maintainer trees.

CONFIG_OF_GPIO is a switch that enables the compilation of the gpiolib-of
module. The module itself handles GPIO lookup via the OF-node tree and
is automatically enabled on all OF systems. It does not export any
public symbols to drivers. There is no reason for them to select or
depend on it in Kconfig.

This series removes any such dependencies from Kconfig. If a given entry
has no other dependencies than OF_GPIO - they are converted to OF to
avoid new symbols popping up for everyone in make config.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Make gpio-watchdog depend on OF && GPIOLIB
- Drop picked up patches
- Link to v1: https://patch.msgid.link/20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com

---
Bartosz Golaszewski (9):
      arm64: Kconfig: drop unneeded dependency on OF_GPIO
      net: mdio: drop unneeded dependency on OF_GPIO
      gpio: drop unneeded Kconfig dependencies on OF_GPIO
      leds: Kconfig: drop unneeded dependency on OF_GPIO
      watchdog: convert the Kconfig dependency on OF_GPIO to OF
      bus: drop unneeded dependency on OF_GPIO
      staging: media: max96712: drop unneeded dependency on OF_GPIO
      power: reset: drop unneeded dependencies on OF_GPIO
      media: i2c: drop unneeded dependencies on OF_GPIO

 arch/arm64/Kconfig.platforms           |  1 -
 drivers/bus/Kconfig                    |  2 +-
 drivers/gpio/Kconfig                   | 53 +++++++++++-----------------------
 drivers/leds/Kconfig                   |  1 -
 drivers/media/i2c/Kconfig              | 12 ++++----
 drivers/net/mdio/Kconfig               |  2 +-
 drivers/power/reset/Kconfig            |  8 ++---
 drivers/staging/media/max96712/Kconfig |  1 -
 drivers/watchdog/Kconfig               |  2 +-
 9 files changed, 29 insertions(+), 53 deletions(-)
---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260304-gpio-of-kconfig-e257ea7c9a09

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

