Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1D367B9B;
	Thu, 27 Aug 2026 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806043; cv=none; b=ErBJM9ruHj2fuAw3akGAvu7YIxVEEr1/kSJFPRaJ+Aw/15Ac5e3Algtdh8cxkrmDuI/0RHRZYWw54mfLlyZRCJEFhUe8To4tOTsBlfd9dcJlBevSFqQsuWwpEP4vNHYkNka9+h22Ky+6FvPZHu9wfJ7T2mXfm8jUh1af3pPna7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806043; c=relaxed/simple;
	bh=mJURxPM2dNs+nb1ZqggqpK5ftHzFT9Snk9Z4A9d+81g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpDsAx9ShY3QWqDBtCraGha3Nbtx2+jU/adI3upchiqMEJMlXFjKjf94Pr+fROtVQbz4i2MROkW2qdKP09MntoRs2GDV37p6PVzZQBnBdRYMPpF6cpaLJhxJEeLtDzYoVxlJthsDiXrEFCLXOWAYOORFirl8EYWiXddWOXaj2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az20AcGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az20AcGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1141F000E9;
	Thu, 27 Aug 2026 04:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806042;
	bh=jyC15Dhw6fwwuD9lJsqWSPmJEvjlAtXHVkMtzv2iEDU=;
	h=From:To:Cc:Subject:Date;
	b=Az20AcGw0Ov7WLiDtbRaLHrXT3YYK5XBTktGeM6XcuQS6hCQlctxkE/POCpKKWITv
	 BzwsFsE0bj6zoXQ0LKJgqHqO58M7PRFaJXehVwC+gHrvGDLOY+tR4O+G80AGgHpjT1
	 CKOAIthNEOFds/9JMl+f9Oeu/FO4pqiIU2+nVijsI8pCRDXNYaMCIuNrMTT0Qfhdbc
	 7wWyMO0pa9uXvZ4Z4q5okI/pj7pXUvc19AfYEMT6Ew3tVpoysZYvNc98HYongG1cMW
	 +e+TZBv3zmrQMTmza1IUKuILA8awBkuNtk0CRttd1BqocEAL9KhjX1wPyAGuf8OX1H
	 iUNdvdAG3Jv0Q==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH 0/2] watchdog: msc313e: Fix issues Sashiko reported
Date: Thu, 27 Aug 2026 04:46:58 +0000
Message-ID: <20260827044700.554333-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series fixes the two issues reported by Sashiko in [1].

[1] https://lore.kernel.org/all/20260826062035.7645D1F000E9@smtp.kernel.org/

Tzung-Bi Shih (2):
  watchdog: msc313e: Fix NULL pointer dereference in PM callbacks
  watchdog: msc313e: Enable clock before accessing hardware registers

 drivers/watchdog/msc313e_wdt.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.55.0.887.g758fc8c411-goog

