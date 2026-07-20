Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3631F98D
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564197; cv=none; b=P2ZTBLXc+WCRMXt1OyKE1TOj1cGRQ98IjczMiV7n1OI1bPkkKJ97M00MMn4+lh8wwnESiYPdxM2YaA0482S8JXWs5zZ79m+C8m640G+t8Xp1ojPGe3GgdeseKunkOlRtVt58Q3eeso8ZXK/b3QwqmCIZrYWeDJN8bgBUiCh8IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564197; c=relaxed/simple;
	bh=9Nfx1s3FDwoJBLQKgyQpoj9kf2lDhklvpCu9QP9A6eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Sc6T5c9VxzgJgmbeoJU+6gw+5jj5JSH2dz7/OWW7SXVrpV6+qHES/Xt+/iGQI+9CfGGr2XztgxVzupU6FyAoQzkogm0gXwtNJi5axOd51zXyoGqdJmYs9g9/32NEtldi1nCxXZmioJmsAYPoZigXdYQrDDk4N48OweO6ybogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3cETB+J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3cETB+J"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceae1ed204so81920545ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784564189; x=1785168989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iMZl7cwhA/4uSTF9pOP+QKBPT4llr3HqZrrfaAtUyuA=;
        b=p3cETB+JS2VD/ZVnzQ6PujtT/7NxSzrlOxRIAsW9SeiJMdJREymT0rAPsOJlJ2IRDX
         xHIg+bWAG8DuyC01BRE6PWBro0Ososww+P/WTvl66R8e9kPDGQuXCqfIEjqXdcZE3dx7
         S/BvZozbEBWFSyD8a2s24cQAMrz7HeUCGSlM65hMq0MPIY1zCEa5F6WxdkrRrBxM2R3i
         Ze8/maB9FZ1d13r2g+l+752x13uyMpZkUeswdh36mSllO1Ce2EYkuqAKqNvoQhaVarGs
         golBjS2qo2AYgMQMyllEOF9g1i8B/xxVkntkQ6/MN1X/vuZYVxiP9BQBz1p+jlAKfI3E
         aZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564189; x=1785168989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMZl7cwhA/4uSTF9pOP+QKBPT4llr3HqZrrfaAtUyuA=;
        b=Mh8q6auS30BT2Vp5oj7n1A0zMyjJ1dRLSE0qe+BkirQYtOHaV4dHUQ5MdQQFy5Syjr
         GFzcYdNhSAYqykbOaVwwzW1lHpctWfLs7nT/1wAvxLAvbF+8IKOwHlt3aOyxPc0vztjg
         VFh2wyxrp4K5QCH6RdSrXj1n2qjrxuefDt0wbvn936FdNYc1GuTJOHvuuBhEUoK/LzMf
         6fuoDFwOvH9+hZ8Zv6Ik0t2A9RLIwU+//gvDHtmByw1AColTk48ga8d12cmufD9gWnJl
         nmrbjHEKKDXsy4J5E64iO6EhHaSQKhT8qvCB+qyqVpfyNaEsGuZ3pP/Vs+LafRqs3qPZ
         vmcw==
X-Forwarded-Encrypted: i=1; AHgh+RpG4jtXcQu8cwBK38m0lZKrWM1D8ConB4ic9t7+meeXGVMQxoKv4JjdfK4AlXEdhadf1gA73UqRcr5vG/H1SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtxOJGWMtzSJIn8bHWVEbFH7pmV0hneFu5iYB2gffa70BRJUx
	Vr1AUNBML39xdiVOeBcVus00Y+xVlD/qcyo5vEzfbnmWFR0Rk+VGYzlG
X-Gm-Gg: AR+sD11Wp4mxqa2TsTaKHmwdY06bFQEnFAmNqtN6rAzMRzdXh0QFHtuwmc16YqVr2oL
	0qIsh3qF4TJc3xtas5NIMPlxSDOWHj7sWgReWjHAjaLfU5WYKr/z1U5f63wpnJBEM3knrNp953E
	2Cw6+KyoJkeBigofN6MpirVqFQ9d3RTF4DxLONpFFww2M2N4fRIjARAr66kSRJbuizyPwErJEev
	6bcwS2V/ABISsgHmrUUVcQuFjBaXyfSyAQnSpMRtQaOazMra1JBN9QcnFmpMN+O2J+s8aCw4RrR
	79YMqCSwrMJudFC47OZt47BQt4n/GP587pGhtroJ0pUeMXxxh20qkUBWpUVG3OvGfNGXdd7KJWR
	z7zj/dMTdU7NBK8fb3BXS0YCgyKz4ALeyjqZLa/zFBReR1Bc8S7LOJ4HR4N8WYmsAQGa0PBAE2o
	GEU5lqIeKNqa1ozbo=
X-Received: by 2002:a17:903:2441:b0:2c2:cf20:213 with SMTP id d9443c01a7336-2cf3499c666mr169947995ad.29.1784564189534;
        Mon, 20 Jul 2026 09:16:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm39055838eec.3.2026.07.20.09.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:16:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:16:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: via_wdt: add missing MODULE_DEVICE_TABLE()
Message-ID: <4f4248f0-8898-4e0a-8d6a-073a91bfe3d9@roeck-us.net>
References: <20260705001613.68871-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705001613.68871-1-pengpeng@iscas.ac.cn>

On Sun, Jul 05, 2026 at 08:16:13AM +0800, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied.

Thanks,
Guenter
