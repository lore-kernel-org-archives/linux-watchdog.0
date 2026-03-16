Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1538F949
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654359; cv=none; b=PCnavwTGCYdL0tbhbig1vCLTwAUTK61gzm20ZPedbs4HUZxt6duJ47Ai3DPofntDogLHSKmDUR9TcWvcuf4QUc5kfb7h7Pq6uqRMOvl1Kt8aAcmG5Q4lMdbdaQ8zZpo3jfTFAMyDZG8FDlF7HYjmFm7kPWzPHPsDh0icW7LMPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654359; c=relaxed/simple;
	bh=Vpj7XblcOBfhTzLdpL+R0P+2mUUD1VQIJTUYQBBtQPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgry+yXbWN1gsTnSIR+09d3NGD8v+IwqEpzkVs97AvXtOmgVGYhb05/Y5yzT/uEc0oFnbLHcQr3bVS3vXUdhsGmq9NJsgX+ULvUDygb0LL0afj4MylXW/LCG81Qy01ikPngn0RBay+5pPreen8b84grVcvIjWuGmeDiWYLE4zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F52FR0Eh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GcE4tAGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F52FR0Eh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GcE4tAGG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64fwe1066849
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=; b=F52FR0EhvI080Bw6
	ZAJNJx0a8UcwiT3pF4CZaST6zvv6FC8R2WEUPwGU+gRdeFs0uVCgYR0x2hqAuiLq
	GIJPeQG7Jo58rFBq3l6pxK1KOXmL1nNKvQp2X4lK1ud+bBmUI2E1pj7K4OrxUUj8
	EreZJmGtfRbMrEwQsViN3qglzA3t43jI+pdjhZ1Y/0y4aDYlRKhDWWGw6X/9f3gL
	EImt+siXIOQQXUd0q6gCYCKY7EXGXlB2sCDkSi9xP1qBslke5TS+K6Qogxl/lb0F
	fxkLqOuUO8xl6aXBNz+gJU0vXnhRPkgLnhTM2E4mq5EuExlAd303cZSBrKJuyyj8
	uiS9pw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027d4hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 09:45:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd722c1a69so2691846085a.0
        for <linux-watchdog@vger.kernel.org>; Mon, 16 Mar 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654356; x=1774259156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=;
        b=GcE4tAGGZeIog+4coq/V6Ug4a1STpB7r7KS6ot5m/8Eskya3G+x9ed7zDcNnKGm9UU
         /dNaG54RwcqZq0SOy6LrOJXiLnUZVVjDXkzCgr//WKnJh+9IvD4QmJApxnQul/Im/oT2
         jMIhWW6qRppXxo6PYJMKg9gYTzCgJPLx7LzAHPX8xXoKQhTTPoss35OO2S7mi24xBqMg
         7tJVhbB0wFnIPIxSfpef9oQNL+8u+rK/p5nxvJxve8dG2DO8xTLpEQlDwQnBBtlGbs2V
         h1oQiDCbGK8D66RiUJmflHJmy91R9DO391hNSpD3Se0Ywm1jqeY03QEl51AR2MzB2DEj
         NDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654356; x=1774259156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=;
        b=njNmhj3ItkDahZ4eHdIolD8bXoJIkp8Ykk+Wx0lGajGAaQNQIYDluGW1gM5x12vGnU
         2DEiwa/C0sB21GymrQH0hsSMswA1KPDCc0A91UvUeAVAGr3iLS3thl0H7emUaIIppcJY
         HOZ9JYG3skw4Pj44pTqf/1v+DXDWW+oABAfgOs+0B0Ld/UcxD26L+rGfeUt+9a/ZqYnF
         Ta4qoWypo7ubiUPaISay5ZnH6E6FsnBKuwiaTGxXdSFrnmh3wdbQnecqTAeZPQg9/rfA
         EIPRMWaGAxdFzEf2zZay24kLXpwknS3VJyCaCn2Vm5D2EYiM4EsXDfYiguFIwSZhCVB9
         d3sw==
X-Forwarded-Encrypted: i=1; AJvYcCUxDFhPsTXpu+7oB85efdj7LGyFcfI4l1iNmEsyAK+5BJozdkL9jairWm6bT7MoO1j54wmsT77SBw2UAaZlug==@vger.kernel.org
X-Gm-Message-State: AOJu0YytIqcFWWzkOmRiZ0g3hz8d2MfhzVjZ92zUCpiqbwicxxdKov3c
	7TQ1DpUgoouijabggiJ22JtxzfqHkNO1BZeetgz8l0ZKifu9iwsgGrumpnnYu4q5H2+zNmN+LeO
	2SW3OMwkappEpkbNWavxqJgdjb6jEETuRLqzLv9bbgMVoJ87cnHVA4Ob1YvSucF0Tlp2Kzw==
X-Gm-Gg: ATEYQzxvcsDs/5l0AwponFWISjTFbmZWIYNXtnScde6o0Vvh0DM5qCXLnftVt04T3QA
	pS5/HztWjXuNxzUoBPsE9jjIf1GyRJvZYhZWYJDpxlgqjJG/YDblowc7JtmOrs/uYs+1jrJH7S9
	8H25GMr9KoitmaI9BHiJtsSQlQH0cGJWWJfUnLswvPcvYWLOOu/RgOq13pwifr/Yoj0ZseLAqo7
	orHL2U0uK9g8Jfoy2AacQecY+z2mqTNk/jpow+m9mn8DdK8sLrj6KjC8z/62ouI5zelEt1L/LMY
	/ARP3p2NMdlkeCkLxeEKMJ7bIY3m5d7PjDd3RcuTt1QrEimPy2h309odiqVEPPHb+aFR0wojWG4
	0zsKLLjoYn39EMN+P5+URxjLFvs2rxBeFYWq5FtMnVOEBs1Dpjg6M
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1624640785a.17.1773654355873;
        Mon, 16 Mar 2026 02:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1624637685a.17.1773654355478;
        Mon, 16 Mar 2026 02:45:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:26 +0100
Subject: [PATCH v2 6/9] bus: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-6-de2f4b00a0e4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vpj7XblcOBfhTzLdpL+R0P+2mUUD1VQIJTUYQBBtQPc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E/BPk3re52ZJWSY5xhnCOBbXVxjU7260Fk+
 srsoMcqMFmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPwAKCRAFnS7L/zaE
 w7ebD/9C5UxsVXbQ5n7GRcwj3aymQcwnmyJt5yL4Rjo3loecX6xlAIkCw6qE4wVvwlikpDiMICH
 Hlu6BqVViA68+gFZjra+HVX4cOzmIN5Etdo2UQVZnpgLkbtFl0aVyfjMXq/KEzefEF1MQ5xW+V0
 8P/5vVxEo/wTwSEUeXu91SjctdqANe9rV+yw8Y7yvO7/VxdJs97L7trXK51vWRpKzzeBGFLwgSM
 6BvxbcfOouG1wqurT5mzb8ndXlGrBBwkK3bL1VwPLaOpprLSCibrFFUHcr/Z+qWyYQOxPjfipIK
 C1PYQRPoXpfYokNYx/wtSlLunVdWAgJUBCbli+AGoHcqL+7B016/ejjMfBXYAMj3ez9oY+Nx2lX
 g63HzmI5tbWpMzltRMaOqJvZ742jn6tUPwfmbzhUwRKb/vZd2F9cQ7xcL5JS5j7QO9OXDQW7Kwb
 bm3sTzDWsRqJLEgbM2zLYkSo5Pm2sUoTFTndNwjNCY1r0+ltSAz2Lty0J+erC8vlj2FyHUIORQu
 4morlORo1RMu3RvdZ1tDEpXN4wof4XKnugvEhbsmPlsYqNKUt5XbyCFJP0/LFquiiQWRfXgPI+i
 Kzs+Uv2OCTkDZo9Oq6IwDVn/idGa4h6W7vMhuxVUixG0QCg5T46K09qvQCgBXcwz06G15PzWuDb
 Pd1gyza78ZAtsXA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 31kP1Za-mBjIHmksdqdNha_PdvlVa-c0
X-Proofpoint-ORIG-GUID: 31kP1Za-mBjIHmksdqdNha_PdvlVa-c0
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7d154 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=tMvFuq0QiVTRqkuSJkEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX0uxyYluw5m4q
 zqK4DKJBfXpdYq1hK9RuEhnxBnBpWelmDV0/PcMQhtGCIO/thLQQZWzZPPBeefuvE9ipqUzXdmi
 J3odGZATzez116O1YbZyf4fUVXvdtvvGgn4HskHhHr1nO/HY+x1RZDjVQUhTq5TUJ09Ur/XsxBk
 vKc7FSnLVeIPx9H+HtEDwJ/qfpIxk5acJnR3JgePj4+0HfarT1tmvmqWdChjYRRK5O9FT34enos
 nKZGdIu9tds2zsXdOeCMszF4BFmPniLJ+zQFo3Heq2tJxqa08iGR6DlQ4TqQ73gguub1w9YKgcC
 SBbG9T+O4ARfr0YkZ+ycpvqD/tzSsP2OjmGRICIJ73Dqkvzs3CLz262Xbz2cw+y0kF/TCTZMiBg
 uKey8irt1LKvKXVPdcsal2mqMMvYuKeI+2T9B4IIIJpV0aUTt3vMM6/lgrFnt7JszMiAVMSGSYz
 iGL9QuUC3HwKITmBGvQ==
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
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3181d8aa32a3e3ec26935afdbde1ef647f425fd5..e4b1db809187fc5f8b39e3950776df94005476ad 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -216,7 +216,7 @@ config TI_SYSC
 config TS_NBUS
 	tristate "Technologic Systems NBUS Driver"
 	depends on SOC_IMX28
-	depends on OF_GPIO && PWM
+	depends on PWM
 	help
 	  Driver for the Technologic Systems NBUS which is used to interface
 	  with the peripherals in the FPGA of the TS-4600 SoM.

-- 
2.47.3

