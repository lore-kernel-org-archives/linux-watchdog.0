Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5B92BE03B;
	Sat,  2 May 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777720979; cv=none; b=BxTwYaU/TosqG69YrB2Rhl/4hJ664uEzclNouoTYTmJyXpXSSv2dFllfE1VS9mtGqDEMnanbsoW1wSOiE/Zl1tqwU/MqHGS42HMNIoWEQBzHibiDgrQV/z8XwjwNPNoI05FSdHlQ5BAzO0iLYZ4/QPKXw4KVUO/HIlcTiP9oQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777720979; c=relaxed/simple;
	bh=Tsit++BdrnrHHKGW2IdaqmhPVDFYdMY17/KgmiH/SxQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=maZc1iXodfeewOkGNFOiUtDK2GaxU6OnRR8Ox8XPrXfIw37nN6tXGdPsu4rCAdkHBljBbnebQ8AgwdGkY7MBYeTc+/HYdLcXUCE+VEkdTtxHWflfsUVUxGIUHJzguD9PtVUxmX8nl1fpGirfRNjph6KAA75x1E7LvpxKcmQSP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VC66a0Mj; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VC66a0Mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777720966; bh=PWAy/WeGAvEk2mc7Ph51cIrj3vzzDaiXxmstD2WFWpY=;
	h=From:To:Cc:Subject:Date;
	b=VC66a0MjgNbl5Ed4Ew1/m2XdiE4BkUFScPQA0lFzGK27j4aD+byFmf4SRBPLdIr4P
	 bQh8Z+Jp6EjmK/VIxpd0VJpS36trJD5BbkTaEC9Zm7pXZ1yeW7spDDwDa1cD+CMBPw
	 BW2jIJRFW8/bnvNgudkkF+/gzG3uM3wOfRGfixCA=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4CA2F82F; Sat, 02 May 2026 19:19:10 +0800
X-QQ-mid: xmsmtpt1777720750tqrn9sn0h
Message-ID: <tencent_61E8FB326F4582DB0074952B9FE4A239CE05@qq.com>
X-QQ-XMAILINFO: MuqDVCpR0KLBIZLEO1nX3cNWVekD2Ur1Xacda0IcNh3nN8+eGr+Jcjrrm2vsGe
	 c1FZUb5t6XV5h8N0t02Bu4No3jMgXuLYlfxkGdeSEUrSp9ECVXACnWjvipuk/cpOK1BzuaQ6ThGa
	 m7KzUF8echKOvDRUObSb2xH/Z9+fGkoWFzUAxpJjgUm8IIwISM0dOoPjXHkf7lq75Fx30zM9hmPV
	 usMRn0KfTVIrefT9MgzEAy5gO69pKHNgmMNM4MIFowZWgc5bLygJt/OmvLbBrzKVfLf5Pw6GbiUy
	 MT6s9H9izQuJQnhudIGBpXnv3ps/Af+NlezkxGGHjsQpdhWt5jghef5rlheJyIe8VlvCsCKIdhFv
	 kZ5pw8Bq8eNPbDC3/iInCbtm4814h3cf9Dxme7FRUalIWYlQAa+kqW+LH23puQbtSOQtT3e+8ZKx
	 NE75Amfh2EZcV0hTTyJl379UrRdlSt9k1LQrYmpGEAmi+t92At+8wLl5k0kh9+nMgqn3juX+q90W
	 34GajBlM5u3WRYk2C+J4grsfypbCtdt16cKsYKZEKxuo4+GWLZLmnEUHihWxMP9aBJDd6IVRumwn
	 jrmgzwayFOPtdfNrA6mJ5MrNVrirIg8xHTE5exbeTZQ0zV/HHAIymcbRcF0gAPDE3yiwGRh8MUlb
	 8ZyI/R/jBotaU4Ga6kkiDb5AyH9SvQQxRs2fgtzb25DzcO8LL96qL3u+PFJccbabJdN8PabtWXBY
	 S/yLiZh6JnnwQu0VjOtkk/COn5Niz0JBK3sqXF7zh+MI2ellHYcnyNRwcqJ+IgO3H1NgnQ1md/Fd
	 S1laviDiq/lVyxkSUMikk0y8wMpH70l+73x4ithmuy3dTGprSoQ3+XI2Yv74UiMf4o5hIQvM1qKY
	 PwB3HMYzSALs+pJg9Gc2pTPkvf/vEStzoBaawSjlGuK6zcG0Nth+A510Ka2F/Cij4WdUp0BwFrkI
	 y8Fxzs/Q7Zd+VQ1Ci2kHlJlqd57f6vyzR9DH/FWRpKaznhoqq/yo0YJNaJejXMfQjDHSHlalTfgb
	 qJ9EKNDJWlCEc4cqS2sa4l0t05K9mejQ5nNHtJls/of8BHe3fN6mATr9kSqNmxvZXrhK97/D+vsq
	 Yf35fM
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Wang Zihan <3772548978@qq.com>
To: linux-watchdog@vger.kernel.org
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Zihan <3772548978@qq.com>
Subject: [PATCH] Documentation: watchdog: Fix typo "oncse" -> "once"
Date: Sat,  2 May 2026 19:19:10 +0800
X-OQ-MSGID: <20260502111910.142992-1-3772548978@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in mlx-wdt.rst documentation.

Signed-off-by: Wang Zihan <3772548978@qq.com>
---
 Documentation/watchdog/mlx-wdt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/mlx-wdt.rst b/Documentation/watchdog/mlx-wdt.rst
index 35e690dea..3778f85d1 100644
--- a/Documentation/watchdog/mlx-wdt.rst
+++ b/Documentation/watchdog/mlx-wdt.rst
@@ -48,7 +48,7 @@ which is optional.
 Watchdog can be started during a probe, in this case it will be
 pinged by watchdog core before watchdog device will be opened by
 user space application.
-Watchdog can be initialised in nowayout way, i.e. oncse started
+Watchdog can be initialised in nowayout way, i.e. once started
 it can't be stopped.
 
 This mlx-wdt driver supports both HW watchdog implementations.
-- 
2.54.0

