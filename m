Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3A40DFB4
	for <linux-watchdog@vger.kernel.org>; Sat,  2 May 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740353; cv=none; b=gaxTK2G4ZEYWXZVLPak1tc908yVu4qcIet1vkiWSnQWKtrey+tKNtP9DZ1RNBhQQ4oZ1Nxirg7LFoKRimiW0jKuon4dwGVdCtzspUxoNpP1PS+SObAc0kM20PTmAflZe4eY5pfN53GH14K+/xXsFpSNqhihZ94JnlyYiebFKGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740353; c=relaxed/simple;
	bh=Fvph8Zszqq3lfS3rZLPKzhDw2zgPpsjbulxUww+qKtg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=N5aur4b1/a6FZc1TgAOKr6AUFD8msCgu6shjIKF2ledwd3+OSEIvcRoFu25IFULon4TBPzDZ12vAIjqM/65cB3ruKr7YngDi+LTiCiwop7BlIb7AYNcIlQt48MzzDCiFtRzj2vOwwHGj3san43rteEouQekGBIIDyCTLUBk+gcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=whO6b8ai; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="whO6b8ai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777740346; bh=Fvph8Zszqq3lfS3rZLPKzhDw2zgPpsjbulxUww+qKtg=;
	h=From:To:Cc:Subject:Date;
	b=whO6b8aiQUMszCaoeEWzoOwpn9UNACnOP8fLQhTUJfzG6wd6qEfp0vFSVgZIdMI4z
	 jn4qzZocvAfVt8smK0IkiDIfrJYFivWTSvm6TLC5nXE8K9hiUWtXw3ynrGXyar6f4X
	 Vt3CM6OeZsVPwtS2j+dsKOukdxWypSBgTfIDWO0U=
Received: from Lang.smartont.net ([2409:8a44:2312:14e1:56d8:1e1e:3f0b:d0f3])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B19286A7; Sun, 03 May 2026 00:44:25 +0800
X-QQ-mid: xmsmtpt1777740265t7j7kzk8k
Message-ID: <tencent_2C2C2463CD6D461897222BBCDCC3A0295C08@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qLJRW/VzT8vvbiCuacbfdp34vTgiLaCxKG/zWBF0VNc2CbRydvnZ
	 lwziV3YCMvXCtnm8u+f4N/6k59bxEA1e0KGwGZaoHWvK2yF9N1IgCvWvgCDz7GD6QrKW2TAUAQUC
	 8hWofZeOu4q2JOcDhWUsMxOF60hia0WPbi0OQXvB4eMlRuU1fBVGtuSKs9HDXFFxky3u7FAAbc27
	 8a3S0TAGgO39zF+IaGjli1GYHWFpFt8NnC0y2q91ONeTFGAti6DXK1q920RP13Y00L6JKx4/GJEA
	 JDZfQ2l+gnghtE8FdlXug3+aeY/tOAKGYeLh1O9jmRjDJ6zj405lOv73JMf+0fWWQDoRWJkb760r
	 W2yFlbTWcvr2HUvJOEdXoqbVxzCv7mpnofJDFrsmQBi+63jXLVEE+rICqqBVpQOCAcIybeWg0VYd
	 XZuH7HtJTaBJ6czH9v1TkaX0dFXRGrHW5e6R3FJGIvANBQKPjlfF3NcVihSrEhvtUKBzU1IVp/EI
	 +sPkY+1fclHH7sEvR5KC6TCdultQoASecosIgArbKfpeqfXef2Q9KlqrrEACCquv8bbgwu9BDdDh
	 KCmGOT+sHSC8ftaaeKBNMRgUkmPxUpvQQ6eQbJHMbwc/e5ai/kLYk2WEPi6nePx+vZ1JxGGPi2Jq
	 kL6QcV373PNAswAnX/EqfFJFH1/f+1wV+8s1uRlA59O2ItvgtnEpxRXpWZNqdefKnY+6nfnyaHKv
	 zG1hP+oGTyYF35+L7B2PlJRMGgJRyMeC13VdwmltXr/xMjCuXRsUnniogarfpfshsmboYITrMuIr
	 jTAuF8hwiPZCMj+zf4t/aJ3P/QMXHGgklztAnMq2Qw6DwigAvDCk9/4VQyzT+TbwVJ+0W4z6+k3x
	 yC6a/j93+8Y7V09PqkAgamRWKIhQb6Xrlc+u/e5sZIpO0nb/yXJPSe1faYhohNWhwK14Y7DpNWWz
	 Kw/W046WxlvSV+vmM98HOd056HzcUgo9hJlFK1dFbg04tIOSkk4ioSei5GbE3dBbXjatbP0Au8jT
	 BD1koJ3P5amVdyeST7v1KveDVgPqlDae3a9O9eLRb/GW/hJfSs
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Wang Zihan <jiyu03@qq.com>
To: linux-watchdog@vger.kernel.org
Cc: randy.dunlap@infradead.org,
	Wang Zihan <jiyu03@qq.com>
Subject: [WITHDRAW] Documentation: watchdog: mlx-wdt typo fix
Date: Sun,  3 May 2026 00:44:19 +0800
X-OQ-MSGID: <20260502164419.1960931-1-jiyu03@qq.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Randy,

I would like to withdraw this patch since you mentioned the same
typo is already fixed in your pending 5-patch series.

Thank you for letting me know.

Best regards,
Wang Zihan

