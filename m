Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CFB4F402C
	for <linux-watchdog@vger.kernel.org>; Thu,  1 Oct 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853924; cv=none; b=HPwt2fqFB9UK892xsvw0zZV2/f3sMKWJuFg4/nHRtqKczh7eSLKLL+TrJL2eGB3XQb4bucmdXsJ5xNAwRQlH1NTzpffhHidurBJaiJkvntTpi+RoR/zXGkBqlf5HLbqr8zS9KNVT6UtMPWaTVMrKV0rXj5dWvPLXRBk4SZ0ZXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853924; c=relaxed/simple;
	bh=vdk16+JiM+pun0h+NLwCZ9YhRB7PrCKjaNjUHkG8fsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7Hyaf+2HgFfLLP1kUrY6F5dEYGgWEfSgWcOxgl9SA94VH0aB07jnLTwuZ6gdpprugtZApalnXmscbjrzqMOdVx3H86YZ5vEPK/X4tsp79dp34uh4a5NhD/Tu9wfGbYXMgY+GcsUspcNcK+cqJ1zC1bgmUS905El1ZWGivureEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOfezKpn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOfezKpn"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ec6188so31519075ad.3
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Oct 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853922; x=1791458722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qc8LVRsblFiIidnFYchNDrmFBxE22bEZYeYNxnC3+cw=;
        b=BOfezKpn142TrzJAJ4Jc0lqdbYF90I5pHxF33DF7tW5K52boBgzv0Omwq16oQ5pCB5
         FYg5LX1b7umFC3OI2XbIK5S4/ef0N90w7Q3skvTmByROFW4MiBikxvxOcUT5IzRwuOi6
         584TL8rI0unFru/aLFGRzeG+PO0ytelEmE/kBYA9h5Tkal1BQy4Q30bJ7o3mIdi9XZKc
         a1HQhcUoYVC705cnBamNkxqGs9slRUHbjqsoKzxlOdLf58uPDwpqYw6PpF9flufqOiRi
         ocWpuRPiiQ2ybQ/bnG6WOSZojxKA5SDaMpxk0NPO9EHtxaJegVrAXt7yL0nG5ZaWzB9i
         hbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853922; x=1791458722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qc8LVRsblFiIidnFYchNDrmFBxE22bEZYeYNxnC3+cw=;
        b=bGEuVHpf7Gsc+D/GUvMpKKKxlGSSBrvL0+Rw2sR173K85ObYbnsNH0vVwa0/6mVo63
         tYGO5qHJIItzK7j+bD3Wu0A/mlh0b5wojL3mPYTtHeMj1DAqZCZ05ppvE+MyeLMQ3/eR
         hDAsXrAr17lsmo1SZdlu9EiRjb4Od1JW8bjxzpqANvemzM5/fwFyoGFFUUH2jS0PdBko
         0Shl1ZRHt+caU8eO5v68vkpBrE/KP/pdW9LPgmpLKDHRtmztV0uR1oGRZNHUmhX5uVcY
         BFyiiG9B/uUVAFb0aANTYnQXT5lHC7U6d/mo/2pklDaFoJLLtZDheHGyQuDiRV28O367
         41sg==
X-Forwarded-Encrypted: i=1; AKwUvBzBxiQCxyhP2P0zwGaDM3KhesrlkP63hGIwMVULv+q2TM/mQjJ8+O3j0ckkeqCEFb14CM7NTLjtbEjhHsKUiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1I9WbNu+a9LYbGN6peSwhxfgGA6Dcppcn953SaIzhzB2tgPg2
	88zJNSiPm77E1D5YyTP1bSoT+T1kA147M+Xb/bGNE1xFOQMBddXA30W8Y8wq7cp9MaU=
X-Gm-Gg: AYBFou3lmlPbVXWiRI0Z0AF+dWtSnEWyTdJ02jfuD70DedvYacB974MZdiCKLITLeNU
	xZtnzto6tiO39i3rf+e8z1S/e4c7Z24ND9tAqSHlucTWb8cq1YWvZ4pRlT10kIv2lSZCvB5UiqB
	gx2v8QlFfAg53wW4g8GkuDs4v0AwCF9MXaTAS+OMmGvmNXenX5D3KwUeIHCELM/FlAihXADAwpw
	lssJVmLa4nnWsKSmtRYvIYU1iUnmM9fQdwBaX+L5PIQvZKtGCmAl2kuuks23orcHSwM6t2x4IeU
	3AhmnZr100eiQNNJi2tQ53e6ZA4tMJjQ4XXmetAgI/R/EALNarxmRAisX760kLDcKKL3ifSyyvB
	uCBgVS+IcxvNhKyq39ajh1rsUagG2MzR3MPdTeHOst9AVIixmx1K/J5Aj81V+lj1cg8GbZ5yacS
	LCCyi7J/vlEOKFN2CzU9vXD7LHGvG8AWAdLDFk5EnMfkJPITn/GwI2Y52w4x8bYHer/b3CD2M93
	/QyVer3aBiG0fNdeS3opn7lmGKvEFgRChsJ/lPro691rfmiW30Boo4ptTeUf5ImbtpWUZJRnB/P
	dEaV12Go/1U2swp3J+F229pP6Js41YzQa7ozOWBnBTtmbIbxS9WWoMEALLQ=
X-Received: by 2002:a17:90b:2dc1:b0:3a4:cbc4:4a98 with SMTP id 98e67ed59e1d1-3a4d19143cdmr3582710a91.64.1790853922034;
        Thu, 01 Oct 2026 04:25:22 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300a90dc9sm9326275ad.18.2026.10.01.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:25:21 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the hwmon-next and watchdog-next branches
Date: Thu,  1 Oct 2026 19:25:18 +0800
Message-ID: <20261001112518.3822560-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <d40a607c-af12-4e56-89e9-de2544b07143@roeck-us.net>
References: <20260928105944.2186541-1-matthias.goergens@gmail.com> <d40a607c-af12-4e56-89e9-de2544b07143@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Guenter,

> If you want to be that explicit, shouldn't that also include the fixes branches
> for both subsystems ?

It should, and a T: line can only name one branch, so the patch cannot
describe your trees correctly.  Please drop it.

The motivation was Sashiko, which used to review against the default
branch of the tree in T:.  Since 28 September it skips a default branch
that mainline already contains and uses linux-next instead, which
carries both your -fixes and -next branches.  So the problem the patch
was meant to solve is now handled on the tool's side.

Thanks,
Matthias
