Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0FF5228
	for <linux-watchdog@vger.kernel.org>; Tue, 21 Nov 2023 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uvO4Qc/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9F1C433C8;
	Tue, 21 Nov 2023 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700529153;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=uvO4Qc/d3j99iIO4d8UhkMi6d3bV+K8qcryGxzY+uiwwnOmFry+s+138o/RT77vUs
	 PcwPXbH97SIWh3QxA8Z5y7cWx0yhm5wCJ7bP07IC2L1p5SfCuWMolAAoklpnM0AW8s
	 QK9BeN/TI5l/V6CD01qplOGQuaJSXeBO5fcMdnF4=
Date: Mon, 20 Nov 2023 20:12:32 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-watchdog@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-curvy-beneficial-jerboa-17120a@nitro>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
