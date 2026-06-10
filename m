Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC912402BB7
	for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2026 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097001; cv=none; b=TZnxywRVHgQ4PdIaC6Dk4KyiwSwb8JAypmOvYMgQmQ8rG58Ujg3K1c9e44PJ749qmcE2bdXaX3NalHdzpGPM9gys68dpYTZt/8z1RcycWexHEywET7hLD6U2E1AzN3kdhWQQEaEpg71i6wIhTR77yCcKIywiUz7iwYNVPAprJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097001; c=relaxed/simple;
	bh=+GjWiKaC2OnqchUlv2D9rocAjfPIOsx/2XusU/J1iWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwHfqoi1NvUxzYqxGMzSh1SZQDpsAKNBrrgwpQxbbFs8BpTDKxLeCctGL2CE+GBPI0+vQ1yaXeelhRcA1wqXMCxJXHig4R8OgjGb1eltgWJ6I4xTBjpo1XPNLi2DT4WVe+AI4OGB6mptpyg6xYro5AyAlVFKWeqAHw7/5o13aYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Ub10W6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Ub10W6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c132ac5ec2so66504185ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 10 Jun 2026 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781097000; x=1781701800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIXVelfC5mVARpl9SDW2zpJ3q4ENvqgn2l0kXpwThRc=;
        b=h9Ub10W6jhgKKZzpEdrY4ysltfw1HK/8Lsh+tgfGX1nWBDDp5QfXeTEC83KNexkMFR
         9ignkm/XPNvv1Ypefe6Zh1Ur9gql4zAQ5X5rUEKkCJHbvc3B2HQ91C8I6qR+hmm33dp0
         p0fBoqoHeOG14mxopg1hZ8e3bw9efxOST06rEkoFkwFIKbQa6I1ZsozOKBbY8wWelHqX
         XD7iPNUaGteQ0s2FY0x9aTdw6uCA/U+1fqkCzaveKdg4KwrmApce31BSGDIKMuaAYUxX
         c500EcpjvyYhzq76jKC4oY5RB61MsEX9NARhujNUqQVPJLccJifZygJX+K34hD/8W8+G
         3JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097000; x=1781701800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIXVelfC5mVARpl9SDW2zpJ3q4ENvqgn2l0kXpwThRc=;
        b=di63NPHquDQvdafTynlWHRmJWnXh8l/5Ih+gn7shF5ygMhm3gl7RF43ZnGZHKvRR+N
         2qmAH7ejoFq+GINn5Iim5/W7IiDPIy6BQMpndauM6Yv/o9MoB9w5WzFPShb5c3OOU0ZO
         vmUzcpqCej1b+nw5sOVGcJD5YTaxplfuZu9TLfHryo4ltOl72oFrHFvoqwH9cfZTTUDA
         o45EZnE1wtVfC8ue2qcba/DHCxNi2YU5ZhFjDAi++Gl8QbYQH/VillxKzdf1DGT4uWL0
         cZ7mCNKo6IW0XmEjgDYVa22xd0whBpboHO/1dl/VRJxflR9JXX9tdljqzqB0WhfsyDUn
         U06w==
X-Forwarded-Encrypted: i=1; AFNElJ9huYvh7b5PwhU4r08Kp3iofoKhmpH1BCsm3QRDHx1CRmQvihO4JhC5ujPn2gBLVpw4zXiMgw58fAHcdKjOhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrTcQXSTFNaGa6eiUXFNDWAzLOuqXyvjThigyYhBFkuRxhU9y
	OQ4l2Y5OtndxgEZvNcHIFssnbVAhMe4FnNwxe3uhs3Ykeys61ydwsax0
X-Gm-Gg: Acq92OGANu8bpqc7h+iRGf97oXuDK7r3sY4D4MD1o3HQKVLEoCaSzWyl3BDdLw/pedq
	D1Ax1V5BoGxTXfOgVFcc7Jll2CH24574rYxkVRVPbr+uvRqCRaepsqH9Dr/7wn+IKn3eyDk/Ce3
	wZbvkmfaF8G+DU8bVbx1IHT3/QSaq3jXRjOocOjyLnOB/yYK3hGtABfIgV1fkGF6eW/cnUSS4hl
	iYMB3dSzCUYcokoks/VhAzV5AXeq+B6ln2t1JUddrXzjY4ZL9FdHNQjh4nunboRP9WbHBlQE8MB
	NV/2KcRI1vNCaes1mbCxORtVPieQaAnlSckpRbpewftET6f5hkBjG9cOIzNCRNtOXVKsb1eqR/j
	tMdlPPQDuukreZVgmQeBJAl+X4yZrxjSXBJWTaTP1pJ4jBwyL13takVWN1TsAg5lS2mggESp7bA
	6jZklbNT9WZ7VvrV7xJwjuSaK8UTaCmT52EvGBZlahpX5ac0s=
X-Received: by 2002:a17:903:f8b:b0:2c1:4d9:c8db with SMTP id d9443c01a7336-2c1e836dfe1mr300951235ad.37.1781097000138;
        Wed, 10 Jun 2026 06:10:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c245dd3b5dsm120735665ad.81.2026.06.10.06.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:09:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Jun 2026 06:09:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Zwane Mwaikambo <zwanem@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: sc1200: Drop unused assignment of
 pnp_device_id driver data
Message-ID: <8110dd6a-f9e9-46dd-899b-f2e038e186ac@roeck-us.net>
References: <0793f81a854f9e5880ad38f54c8583b3d56e5d60.1781081216.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0793f81a854f9e5880ad38f54c8583b3d56e5d60.1781081216.git.u.kleine-koenig@baylibre.com>

On Wed, Jun 10, 2026 at 10:48:22AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The driver explicitly sets the .driver_data member of struct
> pnp_device_id to zero without relying on that value. Drop this unused
> assignments.
> 
> While touching this array simplify the list terminator.
> 
> This patch doesn't modify the compiled array, only its representation in
> source form benefits. The former was confirmed with builds on x86 and
> arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Applied.

Thanks,
Guenter
