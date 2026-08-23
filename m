Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444D351C35
	for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787499901; cv=none; b=pJwQNBb4qqPrNQahDe80GTSD1vhMlCXlPubagEmauQ1Daxgqu5IbElI8zSUiLgF6Mg8Y/m8almKyUIrYwruCcesn+nQ0JSUswML3ral21qv1ahMBKq3qzBCLHnQsDkFxL70ocX2O1k2piJBVY9XpaDwa/bhawx+A8WttBSu7WiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787499901; c=relaxed/simple;
	bh=vRlVII930Y4laAFm98EdFMVl4kyJGMg02lFbR0Upjzk=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=EWIexP4c9ry6hxq5kFzsEEwgZTFIasN30RkRSDv/6ssWo9NEvXnX4kv7utqAGEiJiJtIUdXtiYHK8I20FjnJv31MOAuuuWnVTv+gxoDCJhQ4AHVr1WXDGsfEh36q+35XKaNG9qhn1iVpGrL4b+GowucpQBVQGNnMTZ1Anp+fm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZt/1Jrv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZt/1Jrv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so3538723a91.1
        for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787499900; x=1788104700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iiglj/Fl44XHcS/7FaVGpU9DU0dqoQX8JD6znFnnKAo=;
        b=bZt/1JrvZtGG/pk3H+OFNP0YFUq8HaLpMqn0K4yuitaiK0XvhT+qCuqmARZuMR4Ux8
         qRE/UiEv2AQ7KcgvfCsZJOkYK+X4226qswRja5u4+j2LeOCoHnDPQSNYHmnCVDa1+D56
         PFwgobG8K/oq2TkEt59sVJQBjx8cUhDhXhUAaB6gynn2acwbhJ9Zj0unNOqoCoXxohNN
         PQ4rUAt0zIKCovoMeUyp+vrL/q/MB7CL8IPPsnI0zs19xErlucUuHoP3w/V0Hd4G59zm
         8pXSCqq92hsaXqRABM9XGCulEZgFm6v/hQhU0KxdQwWmTvgubNsJgvSzpZLQho2H8fmn
         w9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787499900; x=1788104700;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iiglj/Fl44XHcS/7FaVGpU9DU0dqoQX8JD6znFnnKAo=;
        b=mcmbByXhjJTk6tFZOof0Bp21DBNIwuPKEk0t6OueeVorv+YfpXmijPCKfMwobkgC4Z
         nOyXCnd2/lMp9wOJAHxT2/9YynSiRnP2n/zb7MxOxOvndCxt4YyD431olh06dyH1v6ul
         BrLHAanf/E5b1aQSod+iLWCyxc+9EuZuxC7Fvv4t3Iryw6s8W6bQGvZ9pw7S7rqVx0zq
         05xB9JtiR77cZgJBu2wO4z6RXHIuquaX/lp8C/8vfC2Bu52//IDGgkUKSq+I1TXyODNK
         pDyGxxluLRWGC8oYULHC6BV6X65sqAaLECwXpbfRQ2MAKVqLsraHam2VX3+etIaQWx5+
         oZ3w==
X-Forwarded-Encrypted: i=1; AHgh+Rogmnyb3XrNFzVzOQqM2vh+0UtWzQR6mu74InWw6d46iUWu3pP5dlr8oSIPTXfhU0qbR7AdZeiYbETGbI1bVQ==@vger.kernel.org
X-Gm-Message-State: AFuF++meT0ljHMWA8AiqsP2CnAEXx18nqmMWJaV+ZAAdqlL2CNTAihgL
	YUi4MILx/5LJC9I3mhQHO3ha2bhanjjAmipg6pG6VvCqrh83TqOK1+gMyjezBLEL
X-Gm-Gg: AR+sD114+/zh5D+splGxIGiXXMdNmxKaQS3R6sajsih1ihFPMZDYULPNM0NlRrOWkaj
	Q7u7Yz9NeMw5knEiJ8MYhIgHgXTT+zoWAEZI9ol+18KuLRfYeRgmwtD7clVNftLN+Jqor1n0s8B
	hoqJxGQtgqQkBw6gwERN3BJoi74rMtv58jl6/3LsMHBeQK/CEuXg6CyH9hkYRd7R4/LzKZsZPnR
	ssgKq/IX+dCPH2HCVR8hNqyvvhrlCUywA49PAi0fnRWKahYKXbdSZwH/LVJ8awdlGXv1aQwaCX+
	uM2TSChhelqymLth/6uK/Z0TxSsiCf9j0jNqW9o8P2QnsmHlzOWDIMlopAGYA0yvgLvF020UIva
	gTNchBwEnlWkWOc840o6C/tnJUbrEJwE5q2nQ27IalsxIeO1nuB3mFTrrThSAvld1nx6H7A4fTw
	7JE0CzuZldZcsQ8a4vMP4+FT1DxqJSj4/KSGt7ugNnUvOlC1c8htdFamknt+EjczO6X16iVEpvc
	wNxxaYlsQpYtekT0Rc3aT2697rAAAX9rTK1kmWOqmpjhvOsNEywvtG6
X-Received: by 2002:a17:90a:f945:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-395c35485b4mr37492644a91.8.1787499899797;
        Sun, 23 Aug 2026 08:44:59 -0700 (PDT)
Received: from manush ([2406:7400:94:a5e3:6c88:cdf4:5469:310])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6989sm16795447c88.2.2026.08.23.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 08:44:59 -0700 (PDT)
Message-ID: <6a8b157b.8e75e0cb.2cc15f.4aae@mx.google.com>
X-Mailer: git-send-email-equivalent-ps1
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: xingyu.wu@starfivetech.com, ziv.xu@starfivetech.com,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Date: 23 Aug 2026 21:14:59 +0530
Subject: [PATCH v2] watchdog: starfive: fix runtime PM usage counter leak in
 pm_start
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

starfive_wdt_pm_start() calls pm_runtime_get_sync() and returns i=
ts=0D=0Aerror code directly on failure. Per Documentation/power/r=
untime_pm.rst,=0D=0Apm_runtime_get_sync() does not drop the usage=
 counter on error, so the=0D=0Acaller is expected to release the =
reference itself. The early return=0D=0Ahere skips that, leaking =
a runtime PM usage count on wdd->parent on=0D=0Aevery failed resu=
me, which prevents the device from being suspended=0D=0Acorrectly=
 afterwards.=0D=0A=0D=0AFix it by calling pm_runtime_put_noidle()=
 before returning, mirroring=0D=0Athe same balance the counterpar=
t starfive_wdt_pm_stop() already=0D=0Amaintains with pm_runtime_p=
ut_sync().=0D=0A=0D=0Av1 only balanced the pm_runtime_get_sync() =
failure path. As Guenter=0D=0ARoeck and the Sashiko AI review bot=
h pointed out, the same leak=0D=0Aremains if the subsequent starf=
ive_wdt_start() call fails: the=0D=0Aruntime PM reference acquire=
d by pm_runtime_get_sync() would still be=0D=0Aheld while returni=
ng an error, again leaving the device unable to=0D=0Asuspend. Dro=
p the reference on that failure path too.=0D=0A=0D=0ASigned-off-b=
y: manushprajwal <manushprajwal555@gmail.com>=0D=0A---=0D=0Av2: A=
lso drop the pm_runtime reference when starfive_wdt_start() fails=
,=0D=0A    not just when pm_runtime_get_sync() fails, per Guenter=
 Roeck and=0D=0A    the Sashiko AI review on v1.=0D=0A=0D=0A driv=
ers/watchdog/starfive-wdt.c | 11 +++++++++--=0D=0A 1 file changed=
, 9 insertions(+), 2 deletions(-)=0D=0A=0D=0Adiff --git a/drivers=
/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c=0D=0Ai=
ndex af55adc4a..b1c2d3e4f 100644=0D=0A--- a/drivers/watchdog/star=
five-wdt.c=0D=0A+++ b/drivers/watchdog/starfive-wdt.c=0D=0A@@ -37=
3,8 +373,15 @@ static int starfive_wdt_pm_start(struct watchdog_d=
evice *wdd)=0D=0A 	struct starfive_wdt *wdt =3D watchdog_get_drvd=
ata(wdd);=0D=0A 	int ret =3D pm_runtime_get_sync(wdd->parent);=0D=0A=
=0D=0A-	if (ret < 0)=0D=0A+	if (ret < 0) {=0D=0A+		pm_runtime_put=
_noidle(wdd->parent);=0D=0A 		return ret;=0D=0A+	}=0D=0A=0D=0A-	r=
eturn starfive_wdt_start(wdt);=0D=0A+	ret =3D starfive_wdt_start(=
wdt);=0D=0A+	if (ret)=0D=0A+		pm_runtime_put_noidle(wdd->parent);=
=0D=0A+=0D=0A+	return ret;=0D=0A }=0D=0A--=0D=0A2.46.2.windows.1

