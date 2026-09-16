Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B0361965
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789534462; cv=none; b=uRgFWIhe8nA9mrDLOChVHufYaGGuuwt1uqXzaksUWc5eW3eEuTWTMo0LchDxUkXpX4Jj5N5ao3ESiAOn3PCSMb0iUWh0HHxjkNrn0sfPNbz+6ewYnl9fTqmelQAOiTFD9pFrWpZqKUEnympM2yMekF08SFSD7Bib23nvuqWc7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789534462; c=relaxed/simple;
	bh=fU7vRJN/RkrHsrR+xp0E2tLiD/3a+xc4dMZXnHRhIWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVKY1OFaGzsSBGsPRpAz7HMZU55wRDROvdbFvNm+ZE4J0JIFW/LzJPpkzrIqS3fL9utC5G94RA0pMHW0ySLOYT5MjTY9ZvlUjfWfKXzvyWEmzwPzexvXyOhrjIO5TV2d8YxXv5vVCi0HXbMpNEgZMZ4vm8HUbtk2tDndZ+KdRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovm5Xnkf; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovm5Xnkf"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so458668a91.1
        for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789534461; x=1790139261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34AsoScSr372HQ81huKFVdThsUFHshWxaz7XBk7BIog=;
        b=ovm5XnkfQviT3GQxHdVnIVLPifcDmCGGEmatz9wRj2ahhiapTxynmvQojAjQCt6AoX
         TKfbbsdwJDgJ8QzPNUfT87Yhnwfs5EsF5DRTTKGzGLLsLJliTruwoCiSJbWXGb469u+9
         gJ2Ld3bypoR+9aV2yZ7fhaF6Kg9GuKWWtG/aeLrprsKoWRFapZYQyaL9pgPbroZ1Nbuv
         Ndw5mzibSkigJjvckCoSbetD1vIlob1RdzuTiduWKtWvS2WgvcJaFolEdjUnl60pjewb
         VoQi4hZdaLDyA/ohAQPdgq6PJF7QOeMw3SXX8IPHzlm5K4BNB8g714Lu+LdL+2OG/gYm
         5g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789534461; x=1790139261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=34AsoScSr372HQ81huKFVdThsUFHshWxaz7XBk7BIog=;
        b=BUAvuR7JUBgmTGZNBzzKse6bIHaLqagqtL48W9dI2RFaE8inlSMpWbaPO9By4xolC/
         VjxMVvd2DHNBrRRHinZ+60b1hsBUIzXhCbsicbo1/vcqeG8ogLasyQ7xBPf8PMtiRB22
         4jAoPvnWe9GNt8K8WYSvbUtqsnWIg2SpGMSG5AAugBfP0gv7AJtMkODzrtk7hEKOgP/z
         l8X6tWL+aXHU2+Tbl59MeeKWbDGmz1tlD7VjH1IHmMXwDaXglrw+rConpi3Hq4moXvUh
         ROiHoOTHjZIystpUk/8/IlsJBmIaLvhjzL2VeNC8fQ+LUMUD68lgC1v7lrhu/BhcijBK
         tAJA==
X-Forwarded-Encrypted: i=1; AKwUvBz13OP/VbSa9/B+XhzmkYiNg3bYtIpHqPPH/6/V6o9hrnBc/yWt9Vb+NyIZAEM80DywLadkdKv6J4wsuI/33A==@vger.kernel.org
X-Gm-Message-State: AFuF++mm7OBUE0bXUikja/n2eFQYGjqlzqlh9Iy4Lwe6e7rsWKzRKl3k
	/VwLT7PP4nRz/Q05Cqct8pvkjgpQ1MNv9nX4Q883+Bl4KKEJAADNw34=
X-Gm-Gg: AYBFou3RLHfnWgnXTFzxCZBV14zTVQ+1LALIShT/Aj3c+e8KgljxVrNDTbf/YHxtzRT
	bFPEdLvYi2jc/IlHWJ8kTdh8Fg6mgFKq1Vr9c3ZyTxfm9FH6oWtTqeB2gWwMwPjugzjN1Hx6Z9h
	uqmbW6eioy5fRCll42t0Wx0Gc5WrXWR8yh3Ji7+0bPYuAztnIIxedXnf7LT6EmdMkWgkvIC3PJ5
	CWy8gEd6lGYfI1DYytIbPL1/S8TbqU6pInzsIZG/bXRUKn2giwq/XE4mVIy9+iONlRqtb3lNeYb
	SaCVOh7qsHErIIx83u6Y9BrnKHeEpy5YuwywMt3tmvWQdxMg+Qo/wwuwAmbD7HFP3TtEFE70cia
	hI8pLwZPnXwEeiTy6qHf/7SB3UWVl9ipVKpk91GK7lOZfP/l4JYvbcQHUfIJAgRWf9DDHgQ+ffF
	iH322APIUbXwZ8ml2t5Wi1BqEwLi4L5YPg/aVwAxK4reute/mcdxDRnHi8E1XYwBo+PgaZRNLLU
	orV9OiOJJ7b
X-Received: by 2002:a17:90a:902:b0:39e:2192:97dc with SMTP id 98e67ed59e1d1-39e2192b682mr1243464a91.6.1789534460596;
        Tue, 15 Sep 2026 21:54:20 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7a3cc9sm2308379a91.14.2026.09.15.21.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:54:20 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: tzungbi@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	triet.hoang.dev@gmail.com,
	wim@linux-watchdog.org
Subject: Re: [PATCH v2 1/8] watchdog: cadence_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed, 16 Sep 2026 11:54:17 +0700
Message-ID: <20260916045417.77262-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqoMxDnKCOARllQC@google.com>
References: <aqoMxDnKCOARllQC@google.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 03:28:04 +0000 Tzung-Bi Shih wrote:

> Not only for resume(); maybe just "PM callbacks"?  This suggestion applies
> to all patches in the series.

You're right! I will update this in v3.

Thanks for review,
Triet
