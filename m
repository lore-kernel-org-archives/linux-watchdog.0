Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01D382362
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654356; cv=none; b=uspfnk680u1ub6ZMsELQAnNmJsXQDglIgoSdzFJrr45Axx4GbG7EnC/AGBTJ+ybOquyVLCoFwGupjitwuza8GmYpcy64XscpGD2k4UJGJFddwL5HQhrFC0Y27/K4mUQpauNEd0TV1qgyT7vC/MuRuWq43YC/Mgm1bqhdirf1nfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654356; c=relaxed/simple;
	bh=zJiRRZHOn7YqYQ+LwAzSJIAhBCW3qgcwJUw7el36TcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5GYdpGl6VSYCIS5BHdL/CLfHGKOzPXzd5cG5srNPZUxwssG/zd1258WEIoSPdilFsTgKPdsk6Rh1cGJcupJpY8uApF4uJQ3qNdlZEHEOQVlT3MDxYwxCj1t6szrC3yQWXOacONu0cePx++Qma9a/U68QBMEeBGEV0n7NX5YTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ah6jhUXp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIGSgYyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ah6jhUXp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIGSgYyt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64fhr2128540
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=; b=Ah6jhUXpoBakze2y
	2w8SGxWQtyIX1qayUBDXigwddz8W/9QJhjLlUh0bV3q18J80OrfPQMFWSdfoGXGK
	Qq+AVFJJUFKI/dIkiFwNpqLSh9yBZ46GlXE7CP7SeHZ2e/aLjXodfZorqDK5nRPf
	OuA85HORY8DDw3pzGERKU26bAV9rzBW8eKmq6Q8+CQMYf6KKb7KnuWRGHT6llzy0
	MRWGzlwyQbJC2SYHpN97KCRd+NgvsnIPQim1aXWSOCoqdF052iOQaMGxU4W/gpqX
	qoBAsxcuRca9afQbM32Nec2Ro1LaXlML3mqQOHfb10aznyfePYELWQ5VIGmGpaOk
	Rig9RA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00an5j8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd83cfb36cso1177238685a.3
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654353; x=1774259153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=;
        b=dIGSgYytIRfVS0iwzabuXeyCJKcZFtDWjdWTsb+8m+JYx9eADOaqwi8TkGo05wM77f
         Z4XX+o2kjU5ZRoovKAse93YOG/PBV7CY+Sm1YfMeD9+t4vNzCwDZDhY440pba7jYfBD3
         BNsh2WlfSO3fZfrDydTrsCLU2xeiDDLce1tGPkJl5uP+c9/cMi2QeWG0INjWnk5/2CMD
         GHFGtVvsTNZ/RUaipTc8AeEH1Bk7bm0B3yjgSKYcgGANXdjSjuTvXhbSBVLFTFAn8dN9
         954gR4WIqqY32bAiEpMDE17enOR5SMn+OafmICOIt64hPnkf5pQxRsXW/qVBat5ufxgG
         EeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654353; x=1774259153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=;
        b=px4nQg9xPzhmIKuotd1++ULE735PCrbS4r8+BQiIpwJV2lHHCHZ33FxVWPcTTDUmw9
         vHcnQLc6ltVzNwcGnDL0zGy34zfdtVji/jynL/WJfCWWcZdKnGjaK+ES7LY0XrJrkjQu
         qmBjkJUtILw69iGS1xqUKZPbyxBVvmHJRLTva9UMLyL30goZE3fVIwJUTIx1Q0+BlWcX
         6VPWvBFLvsmRNusLUPHwSuEHFJv++h4clp7ogRFORphWT5fLXuYADxvb0Fm+8UHBULB2
         3RL1YUj3eOTx8JduaioVIv4W+EILeiA+vXlgPRmK+QvZklAfkLtLrGrq/WEWWDGNs58H
         De9g==
X-Forwarded-Encrypted: i=1; AJvYcCVad0jrUXAb8xudZFHWaGRV6U4/vtwphQNrw9EAdWFiPARXwQv4XPZuSWdMFKEzLU26qtMV0dnSyHWB8oEqvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYl1Lzx2VotahGqqRbOui6UUejBNg0m6P8DMacZ54sH78eOyt
	S6haSZSnEC8gIwlPnlDAe8uc5FlxNabU+l0YXlRoWa57kJwc0ark+/n0TSp+wYv1D5+0G9WMsjb
	CIU0ye7YqDye/aw/uvO45olWe0vR7LXEAesYgh8Ug6v0npydaJJ1FAut8XCzlV2LwB3fVkw==
X-Gm-Gg: ATEYQzwE+FjuSSBFoUfIdpwYeaGTots2NqEkQw5d5NVFUie7LF5cgv8yGgQzRJuQXm5
	O1Gr9ATx9meo7b9adClRxl1KyoBUIj34qA5ooNnbPAg6uNmo51fnHP2SX9NaKb6JDLFDCaVX9xB
	NwscfUl+REVSlrS3q+ft6dFyJqza3vYx9fTWgjGrM0JgrteLU5u5Anw9pd9OqMY6TsEifE5dlWU
	ktFmNcp7zJL8nSl0N4LJD42OBctYMUDTISF0einFrJqY+aBkDjLvil3AFXhRtrdnIGTpjRr4rpd
	csDqnxrnVlTSyXyeGyQuSfBO5wSYtUsgf1Gy8yX5s/z/xts2FrtG2RZHuONjRWACH6nU4gL9T2S
	3cuFyw+2JM3WfLYVWL+XuSlmQmYnU2372fZKYevJ5Lo7OXdTgpAN+
X-Received: by 2002:a05:620a:4044:b0:8cd:8447:2438 with SMTP id af79cd13be357-8cdb5ac4741mr1453870385a.36.1773654353299;
        Mon, 16 Mar 2026 02:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4044:b0:8cd:8447:2438 with SMTP id af79cd13be357-8cdb5ac4741mr1453868485a.36.1773654352832;
        Mon, 16 Mar 2026 02:45:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:25 +0100
Subject: [PATCH v2 5/9] watchdog: convert the Kconfig dependency on OF_GPIO
 to OF
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-5-de2f4b00a0e4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zJiRRZHOn7YqYQ+LwAzSJIAhBCW3qgcwJUw7el36TcQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E9Wjg25U44jwuhf3siwRv6gc1FrTGrZYCag
 DWx38GqUKiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPQAKCRAFnS7L/zaE
 w8FnEACjGpR8zaC1w1NeBaLCJvktzj4NhYyW2Td8DUd/H42BEdQFLueq4ukzXtCUXnHdHSdYlxX
 5u85kdqwdApTbieFxlcUadqplP0P27zARAEwj8BjR6bXmDtxbyL9zA5AskPF15evHuAhtsb0vLp
 rWJ/hPriZFRMOTvoiz306zGosgjHeo5b7IFdBRXQKj9pWZu9KC+6nj5Dde/Ek3mIsw7+7RlR+uL
 QLlJnoVNjOKlMMbwrMF8wLuyGxcetuCLacwTtrAUIPDb8Wvg+XSlQ61HFsVAI+6edYFrdWNBKZO
 qAuA/aWE+2oLqr2TcjOEd9gTRLahdebgddcpyr3CudMSPfCe0ZsfO7omWEYO+mh4eu4gObaIOFi
 rSbIFdwsXpTDZyGm8d1I5QasUJ3+T+m5Xxx3yz/Xnw5U+5ch1XQ2oj8rtwYXR4/xPwKE+PhAyev
 EfAmjkak0AwcGfVxvGVwN2Hsn+3MujSJYtzJKGNWR7FqZcI4vanexFwbfhQUBEab+O3yPbi9B8A
 /L20/ccFo1EBkUthx1vFD1wCRe5aIuUQ6rQ3XskhBK7QPd07CNiGavrvpP18ZsC13Tt+iPg8Gd3
 9cZ+OAZ9R7FbhBlqGEwWzhdvmPW/KCw3MbJmuyMjozO0JiauqgeMASM0B722UCBXMoO1nFINRbo
 DDxY+Xizi+tKYMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: cWvBQ3z-uKgrAivdeG7NLhS7jJW-j-6J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfXzeGmsNBahKp1
 jGisD73TnNJFF/iWGJNfM9EykWQORzrHFU2e4yS044l2hUe+Bugdrjlc1mJBacAMFsavKsCQAAr
 G0ml2JzE0ZgRDc8kdUYkVNrrbtuzNR/kFXaSw1YPY6D0XigCcI952HPG5wZ/pb/fd5cw5BkS4j2
 iNNdCmmeZVTqKJQu959dwcKImAXgnVk5hgq0110S14iiL6jvVvjzDG9gaHx8+KllD5TOw5/3QF0
 tWGPaxvhaVDUImSf2ZSmb+w68a1LBAd8aNjnpRhaq390ssU9Ato74IEzgAbLw7oAGnUxiW6qDah
 3wefe+478EMQtoNWWxpCkzOUp5s6XTppo4I2RVGq2FHVL3+gMqitY8KzGvZ3ePm6fzgt0lo9nYA
 QgmBIhCxkgqn6+eJvu5wim8GzWpnm/6ZeMfrcOve3mH71tLjQ3e8Vvspxn8XJtoC6hOhlDcH0sW
 0vFtTjr3sMdg7nk+KDw==
X-Proofpoint-ORIG-GUID: cWvBQ3z-uKgrAivdeG7NLhS7jJW-j-6J
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b7d151 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=_jlGtV7tAAAA:8
 a=EUspDBNiAAAA:8 a=KiQ1yeRyPa_UOXqLYlIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly. We could simply remove the dependency but in order to avoid
a new symbol popping up for everyone in make config - just convert it to
requiring CONFIG_OF.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ab1d5d6df5f32f084c893a7af54d040082a3b6f3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on OF && GPIOLIB
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device

-- 
2.47.3

